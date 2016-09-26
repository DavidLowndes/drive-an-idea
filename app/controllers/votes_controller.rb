class VotesController < ApplicationController
  def create
    
    @vote = Vote.new(value: params[:value])
    @vote.user = current_user
    @vote.idea = Idea.find(params[:idea_id])
    if @vote.save
      flash[:success] = 'Thanks for voting!'
      redirect_to idea_path(@vote.idea)
    end
  end
end
