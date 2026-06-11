class Company < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :stocks, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
