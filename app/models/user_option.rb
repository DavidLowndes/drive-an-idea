class UserOption < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
