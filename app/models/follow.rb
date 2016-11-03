# Follow model
class Follow < ApplicationRecord
  belongs_to :idea
  belongs_to :user
  
  def self.create_follow(params)
    # Check if the user is already following the idea
    follows = Follow.where(user_id: params[:user], idea_id: params[:idea])
    if follows.empty?
      # Create follow
      Follow.create(user: params[:user], idea: params[:idea])
    end
  end
end
