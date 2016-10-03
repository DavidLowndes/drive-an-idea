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
    "#{first_name} #{last_name}".strip if first_name || last_name
    'Anonymous' # If no name is entered then 'Anonymous' is displayed
  end
end
