# Votes Controller
class VotesController < ApplicationController
  def create
    # Delete any votes that already exist for this user and idea.
    # Shouldn't be possible to have multiple votes from the same user 
    # on one idea but just in case...
    votes = Vote.where(user_id: current_user, idea_id: params[:idea_id])
    if votes.empty?
      flash[:success] = 'Your vote has been registered! Thanks for voting!'
    else
      votes.destroy_all
      flash[:warning] = 'Your vote has been updated! Thanks for voting!'
    end

    # Create the new vote
    vote = Vote.new(value: params[:value])
    vote.user = current_user
    vote.idea = Idea.find(params[:idea_id])
    
    if vote.save
      IdeaMailer.send_vote_notification(vote).deliver_later
    end

    # Create follow for user and idea if it doesn't exist already
    Follow.create_follow(user: current_user, idea: vote.idea)

    redirect_to idea_path(vote.idea)
  end
end
