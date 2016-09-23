class Idea < ApplicationRecord
  belongs_to :user
  
  validates :text, presence: true, length: { minimum: 3 }
end
