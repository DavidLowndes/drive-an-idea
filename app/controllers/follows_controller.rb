# Follows Controller
class FollowsController < ApplicationController
  # One-time code that will create follows for everyone who should have one
  def refresh_follows
    if current_user.admin?
      User.all.each do |user|
        user.ideas.each do |user_idea|
          Follow.create_follow(user: user, idea: user_idea)
        end
        user.comments.each do |comment|
          Follow.create_follow(user: user, idea: comment.idea)
        end
        user.votes.each do |vote|
          Follow.create_follow(user: user, idea: vote.idea)
        end
      end
      flash[:success] = "Follows refreshed."
      redirect_to :back
    else
      flash[:danger] = "You can't do that."
      redirect_to :back
    end
  end
end
