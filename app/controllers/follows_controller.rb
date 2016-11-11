# Follows Controller
class FollowsController < ApplicationController

  # One-time function that will create follows for everyone who should have one
  def refresh_follows
    if current_user.admin?
      User.all.each do |user|
        # Follow every idea they've created, commented on, or voted on.
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
      flash[:success] = 'Follows refreshed.'
    else
      flash[:danger] = 'You can\'t do that.'
    end
    redirect_to '/'
  end

end
