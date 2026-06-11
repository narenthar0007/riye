class TeamHead < ApplicationRecord
  has_many :teams, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :aadhaar_number, presence: true, uniqueness: true, length: { is: 12 }
  validates :contact_number, presence: true, format: { with: /\A[0-9]{10}\z/, message: "must be 10 digits" }
  validates :gender, inclusion: { in: %w[Male Female Other], message: "%{value} is not a valid gender" }
  validates :age, presence: true, numericality: { greater_than: 18, less_than: 100 }
  validates :dob, presence: true
  validates :address, presence: true

  # Calculate age from date of birth if not provided
  before_validation :calculate_age_from_dob

  private

  def calculate_age_from_dob
    if dob.present? && age.blank?
      self.age = Date.current.year - dob.year
      self.age -= 1 if Date.current < dob.years_since(age)
    end
  end
end
