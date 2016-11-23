# Comment model
class Comment < ApplicationRecord
  include PublicActivity::Common
  
  belongs_to :idea
  belongs_to :user
end
