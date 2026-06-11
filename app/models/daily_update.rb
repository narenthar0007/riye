class DailyUpdate < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy

  def approved?
    self.approved
  end
end
