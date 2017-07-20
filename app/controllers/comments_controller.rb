# Comments Controller
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_idea, except: :create
  load_and_authorize_resource param_method: :my_sanitizer
  load_and_authorize_resource through: :current_user

  def create
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.create(comment_params)
    @comment.user = current_user   
    if @comment.save
      # Create comment Activity
      @comment.create_activity :create, owner: current_user
      # Create follow
      Follow.create_follow(user: current_user, idea: @comment.idea)
      # Send Email
      @followed_users = Follow.where(idea_id: @idea.id)
      @followed_users.each do |fuser|
        user = User.find(fuser.user_id)
        IdeaMailer.send_idea_comment(@comment, user, @idea).deliver_later
      end
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
  end
  
  def update
    authorize! :update, @comment
    respond_to do |format|
      if @comment.update(comment_params)
        # Update comment Activity
         @comment.create_activity :update, owner: current_user
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
    # Destroy comment Activity
    @comment.create_activity :destroy, owner: current_user
    @comment.destroy
    flash[:notice] = 'Comment was successfully deleted'
    redirect_to idea_path(@idea)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
  
  def set_idea
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.find(params[:id])
  end

  def my_sanitizer
    params.require(:comment).permit(:body)
  end
end
