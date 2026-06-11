class ApiAccess < ApplicationRecord
  belongs_to :user, optional: true

  before_validation :generate_keys, on: :create

  validates :access_key, presence: true, uniqueness: true
  validates :name, presence: true

  scope :active, -> { where(active: true) }
  scope :expired, -> { where('expires_at < ?', Time.current) }

  def generate_keys
    # Generate unique access_key
    loop do
      self.access_key ||= SecureRandom.alphanumeric(18)
      break unless ApiAccess.exists?(access_key: access_key)
    end

    # Generate secret_key
    self.secret_key ||= SecureRandom.alphanumeric(32)

    # Default active
    self.active = true if active.nil?
  end

  def expired?
    expires_at.present? && expires_at < Time.current
  end

  def active?
    active && !expired?
  end

  def permissions_array
    return [] if permissions.blank?
    return permissions.split(',').map(&:strip) if permissions.is_a?(String) && !permissions.start_with?('[')
    begin
      JSON.parse(permissions)
    rescue JSON::ParserError
      permissions.split(',').map(&:strip)
    end
  end

  def has_permission?(permission)
    return true if permissions.blank?
    permissions_array.include?(permission.to_s)
  end

  def update_last_used
    update_column(:last_used_at, Time.current)
  end

  private

  def generate_keys
    # Generate unique access_key
    loop do
      self.access_key ||= SecureRandom.alphanumeric(18)
      break unless ApiAccess.exists?(access_key: access_key)
    end

    # Generate secret_key
    self.secret_key ||= SecureRandom.alphanumeric(32)

    # Default active
    self.active = true if active.nil?
  end
end
