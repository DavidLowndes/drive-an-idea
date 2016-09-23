class Idea < ApplicationRecord
  validates :text, presence: true, length: { minimum: 3 }
end
