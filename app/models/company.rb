class Company < ApplicationRecord
  has_many :users
  validates_presence_of :company_name
  validates_uniqueness_of :company_name
end
