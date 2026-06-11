class Team < ApplicationRecord
  has_many :workers
  belongs_to :team_head

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :nature_of_skill, presence: true
end
