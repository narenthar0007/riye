class BankDetail < ApplicationRecord
  belongs_to :worker

  validates :name_of_beneficiary, presence: true, length: { minimum: 2, maximum: 100 }
  validates :account_number, presence: true, uniqueness: true, 
            format: { with: /\A[0-9]{9,18}\z/, message: "must be 9-18 digits" }
  validates :bank_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :ifsc_code, presence: true, uniqueness: { scope: :account_number }, 
            format: { with: /\A[A-Z]{4}0[A-Z0-9]{6}\z/, message: "must be valid IFSC format (e.g., SBIN0001234)" }
  validates :branch_name, presence: true, length: { minimum: 2, maximum: 100 }

  # Ensure one bank detail per worker
  validates :worker_id, uniqueness: { message: "can only have one bank detail record" }

  # Format IFSC code to uppercase
  before_validation :format_ifsc_code

  def formatted_account_number
    # Mask account number for security (show only last 4 digits)
    return account_number if account_number.blank?
    masked = "*" * (account_number.length - 4)
    masked + account_number.last(4)
  end

  private

  def format_ifsc_code
    self.ifsc_code = ifsc_code&.upcase
  end
end
