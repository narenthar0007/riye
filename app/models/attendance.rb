class Attendance < ApplicationRecord
  belongs_to :worker

  # Returns true if the attendance was edited after creation
  def edited?
    if updated_at.present? && created_at.present?
      updated_at > created_at
    else
      false
    end
  end

  # Returns true if the attendance is approved
  def approved?
    !!self.approved
  end
end
