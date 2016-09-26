class CommentsController < ApplicationController
  def create
      @idea = Idea.find(params[:idea_id])
      @comment = @idea.comments.create(comment_params)
      @comment.user = current_user
    if @comment.save
      redirect_to idea_path(@idea)
    else
      render 'comments/form'
    end
  end
  
  def destroy
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.find(params[:id])
    @comment.destroy
    flash[:notice]="Comment was successfully deleted"
    redirect_to idea_path(@idea)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
