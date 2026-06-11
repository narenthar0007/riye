class User < ApplicationRecord
  # PW : Login@bv2025
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # Define roles enum
  enum :role, {
    employee: 0,
    admin: 1,
    manager: 2,
    owner: 3
  }

  # Validations
  validates :role, presence: true
  validate :admin_role_validation, on: [:create, :update]

  # Set default role
  after_initialize :set_default_role, if: :new_record?

  # Authorization methods
  def can_create_users?
    admin? || owner? || super_admin?
  end

  def can_edit_users?
    admin? || owner? || super_admin?
  end

  def can_create_admin?
    super_admin?
  end

  def can_edit_user?(target_user)
    return false if self == target_user && role_changed? && role == 'employee' # Can't demote yourself
    return true if owner? || super_admin?
    return true if admin? && (target_user.employee? || target_user.manager?)
    return true if manager? && target_user.employee?
    false
  end

  def can_delete_user?(target_user)
    return false if self == target_user # Can't delete yourself
    return true if owner? || super_admin?
    return true if admin? && (target_user.employee? || target_user.manager?)
    false
  end

  def super_admin?
    email.include?('bluvent@gmail.com')
  end

  def display_name
    email.split('@').first.titleize
  end

  def role_badge_class
    case role
    when 'admin'
      'badge bg-danger'
    when 'manager'
      'badge bg-info'
    when 'owner'
      'badge bg-warning'
    else
      'badge bg-secondary'
    end
  end

  def role_display
    case role
    when 'admin'
      'Administrator'
    when 'manager'
      'Manager'
    when 'owner'
      'Owner'
    else
      'Employee'
    end
  end

  # Scope for filtering users based on current user permissions
  def self.accessible_by(current_user)
    return all if current_user.owner? || current_user.super_admin?
    return where.not(role: 'owner') if current_user.admin?
    return where(role: 'employee') if current_user.manager?
    where(id: current_user.id) # Employees can only see themselves
  end

  private

  def set_default_role
    self.role ||= :employee
  end

  def admin_role_validation
    return unless role_changed? && admin?
    
    # Check if current user (in context) can create admin
    current_user = User.current if defined?(User.current)
    if current_user && !current_user.super_admin?
      errors.add(:role, "Only super admins can create or promote users to admin role")
    end
  end

  # Thread-safe way to track current user for authorization
  def self.current
    Thread.current[:current_user]
  end

  def self.current=(user)
    Thread.current[:current_user] = user
  end
end
