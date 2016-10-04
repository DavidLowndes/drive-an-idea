# User model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :user_option
  has_many :ideas, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  def full_name
    return "#{first_name} #{last_name}".strip if first_name.present? || last_name.present?
    email # If no name is entered then their email is returned instead
  end
end
