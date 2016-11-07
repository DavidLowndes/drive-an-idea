# Alert model
class Alert < ApplicationRecord
  belongs_to :idea
  belongs_to :user
end
