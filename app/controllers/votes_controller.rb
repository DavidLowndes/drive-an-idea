class VotesController < ApplicationController
  def create
    # Initialise vars
    @vote = Vote.new(value: params[:value])
    @vote.user = current_user
    @vote.idea = Idea.find(params[:idea_id])

    # Has the user already voted?
    votes = Vote.where(:user_id => current_user, :idea_id => params[:idea_id])

    if votes.empty?

      # If not, save as normal
      if @vote.save
        flash[:success] = 'Thanks for voting!'
        redirect_to idea_path(@vote.idea)
      end

    else

      # If so, delete old, create new
      votes.destroy_all
      if @vote.save
        flash[:warning] = 'Your vote has been updated!'
        redirect_to idea_path(@vote.idea)
      end
    end
  end
end
