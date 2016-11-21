# Comments Controller
class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource param_method: :my_sanitizer
  load_and_authorize_resource through: :current_user

  def create
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      # Track a new comment
      @comment.create_activity :create, owner: current_user
      # Create follow
      Follow.create_follow(user: current_user, idea: @comment.idea)

      # Refresh alerts for everyone
      User.all.each do |user|
        alert = user.alerts.where(idea: @comment.idea).first
        if alert.nil?
          # Create alert if it doesn't exist
          Alert.create(
            user: user, idea: @comment.idea, active: 1, text: 'New Comment!'
          )
        elsif alert.active.zero?
          # Reset the alert
          alert.active = 1
          alert.text = 'New Comment!'
          alert.save
        end
      end

      redirect_to idea_path(@idea)
    else
      render 'comments/form'
    end
  end
  
  def edit
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.find(params[:id])
  end
  
  def update
    authorize! :update, @comment
    @idea = Idea.find(params[:idea_id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html {
          redirect_to @idea, notice: 'Comment was successfully updated.'
        }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.find(params[:id])
    @comment.destroy
    @comment.create_activity :destroy, owner: current_user
    flash[:notice] = 'Comment was successfully deleted'
    redirect_to idea_path(@idea)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def my_sanitizer
    params.require(:comment).permit(:body)
  end
end
