# Follows Controller
class FollowsController < ApplicationController
 #def create
 #  # Initialise vars
 #  @follow = Follow.new
 #  @follow.user = current_user
 #  @follow.idea = Idea.find(params[:idea_id])
 #
 #  # Is the user already following this idea?
 #  follows = Follow.where(user_id: current_user, idea_id: params[:idea_id])
 #  if votes.empty?
 #    # If not, save as normal
 #    if @vote.save
 #      flash[:success] = 'Your vote has been registered! Thanks for voting!'
 #      redirect_to idea_path(@vote.idea)
 #    end
 #  else
 #    # If so, delete old, create new
 #    votes.destroy_all
 #    if @vote.save
 #      flash[:warning] = 'Your vote has been updated! Thanks for voting!'
 #      redirect_to idea_path(@vote.idea)
 #    end
 #  end
 #en
 
end
