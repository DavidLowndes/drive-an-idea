class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :ideas   
  has_many :comments
  has_many :votes   
         
  def full_name
   return "#{first_name} #{last_name}".strip if (first_name || last_name)
   "Anonymous" #If no name is entered then 'Anonymous' is displayed
  end
  
end
