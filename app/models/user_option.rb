class UserOption < ApplicationRecord
  belongs_to :user, dependent: :destroy
  
  def anonymous_comments_default?
    anonymous_comments_default == 1
  end
  
  def real_time_voting_default?
    real_time_voting_default == 1
  end
  
  def reveal_voter_details_default? 
    reveal_voter_details_default == 1
  end
end
