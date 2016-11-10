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
      # Create follow
      Follow.create_follow(user: current_user, idea: @comment.idea)
      
      # Refresh alerts for everyone
      User.all.each do |user|
        alert = user.alerts.where(idea: @comment.idea).first
        if alert.nil?
          # Create alert if it doesn't exist
          Alert.create(user: user, idea: @comment.idea, active: 1)
        else
          # Reset the alert
          alert.active = 1
          alert.save
        end
      end
      
      redirect_to idea_path(@idea)
    else
      render 'comments/form'
    end
  end
  
  def destroy
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.find(params[:id])
    @comment.destroy
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
