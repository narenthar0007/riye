class Project < ApplicationRecord
  belongs_to :company
  belongs_to :user
  
  # Validations
  validates :name, presence: true
  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :customer_budget, presence: true, numericality: { greater_than: 0 }
  validate :end_date_after_start_date
  
  # Scopes
  scope :overdue, -> { where('end_date < ?', Date.current) }
  scope :upcoming, -> { where('start_date > ?', Date.current) }
  scope :active, -> { where('start_date <= ? AND end_date >= ?', Date.current, Date.current) }
  
  # Methods
  def overdue?
    end_date.to_date < Date.current.to_date
  end
  
  def upcoming?
    start_date.to_date > Date.current.to_date
  end
  
  def active?
    start_date.to_date <= Date.current.to_date && end_date.to_date >= Date.current.to_date
  end
  
  def status
    return 'overdue' if overdue?
    return 'upcoming' if upcoming?
    'active'
  end
  
  def status_color
    case status
    when 'overdue'
      'danger'
    when 'upcoming'
      'info'
    when 'active'
      'success'
    else
      'secondary'
    end
  end
  
  def duration_days
    (end_date - start_date).to_i
  end
  
  def days_remaining
    return 0 if overdue?
    (end_date - Date.current).to_i
  end
  
  private
  
  def end_date_after_start_date
    return unless start_date && end_date
    
    if end_date < start_date
      errors.add(:end_date, 'must be after start date')
    end
  end
end
