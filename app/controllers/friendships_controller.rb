#
class FriendshipsController < ApplicationController
  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    respond_to do |format|
      format.html {
        redirect_to :back, notice: 'Subscription Removed!'
      }
    end
  end
end
