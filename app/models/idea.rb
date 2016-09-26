class Idea < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :text, presence: true, length: { minimum: 3 }
end
