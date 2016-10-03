# Ability model
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :update, Idea do |idea|
        idea.user == user
      end
      can :destroy, Idea do |idea|
        idea.user == user
      end
      can :update, Comment do |comment|
        comment.user == user
      end
      can :destroy, Comment do |comment|
        comment.user == user
      end
      can :create, Idea
      can :create, Comment
      can :read, :all
    end
  end
end
