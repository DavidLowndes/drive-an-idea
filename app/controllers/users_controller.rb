# Users Controller
class UsersController < ApplicationController
  def search
    @users = User.search(params[:search_param])

    if @users
      @users = current_user.except_current_user(@users)
      render partial: 'friends/lookup'
    else
      render status: :not_found, nothing: true
    end
  end

  def my_ideas
    @user = current_user
    @search = @user.ideas.ransack(params[:q])
    @ideas = @search.result.order(created_at: :desc).paginate(page: params[:page],per_page: 5)
  end

  def my_area
    @friendships = current_user.friends
    @user = current_user
    @recent_ideas = Idea.where(user: current_user)
                        .order(created_at: :desc).limit(5)

    recent_comment_ids = @user.comments.order(created_at: :desc)
                              .pluck(:idea_id).uniq[0..4]
    @commented_ideas = Idea.find(recent_comment_ids)
    @activities = PublicActivity::Activity.order("created_at desc")
    .where(owner_id: current_user.friend_ids, owner_type: "User")
    .paginate(page: params[:page],per_page: 5)
  end

  def show
    @user = User.find(params[:id])
    @search = @user.ideas.ransack(params[:q])
    @ideas = @search.result.order(created_at: :desc)
  end

  def my_friends
    @friendships = current_user.friends
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)

    if current_user.save
      redirect_to :back, notice: 'Subscription added!'
    else
      redirect_to :back, flash[:error] = "There was an error adding
                                                    user as friend"
    end
  end
end
