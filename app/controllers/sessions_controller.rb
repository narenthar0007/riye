class SessionsController < ApplicationController
  before_action :authenticate_user!
  
  def switch_user
    email = params[:email]
    password = params[:password]
    
    # Find user by email
    target_user = User.find_by(email: email)
    
    if target_user.nil?
      render json: { 
        success: false, 
        error: 'User not found with this email address.' 
      }, status: :unprocessable_entity
      return
    end
    
    # Validate password
    unless target_user.valid_password?(password)
      render json: { 
        success: false, 
        error: 'Invalid password for this user.' 
      }, status: :unauthorized
      return
    end
    
    # Check if current user has permission to switch to target user
    unless can_switch_to_user?(current_user, target_user)
      render json: { 
        success: false, 
        error: 'You do not have permission to switch to this user.' 
      }, status: :forbidden
      return
    end
    
    # Log the user switch for audit purposes
    Rails.logger.info("User switch: #{current_user.email} (#{current_user.role}) -> #{target_user.email} (#{target_user.role})")
    
    # Store original user in session for potential "switch back" functionality
    session[:original_user_id] ||= current_user.id
    
    # Sign in the target user
    sign_in(target_user, bypass: true)
    
    render json: { 
      success: true, 
      user_email: target_user.email,
      user_role: target_user.role,
      message: "Successfully switched to #{target_user.email}"
    }
  end
  
  private
  
  def can_switch_to_user?(current_user, target_user)
    # Owners can switch to any user except other owners (unless they're super admin)
    if current_user.owner?
      return true if target_user.employee? || target_user.manager? || target_user.admin?
      return current_user.super_admin? if target_user.owner?
    end
    
    # Admins can switch to employees and managers only
    if current_user.admin?
      return true if target_user.employee? || target_user.manager?
    end
    
    # Managers can switch to employees only
    if current_user.manager?
      return true if target_user.employee?
    end
    
    # Super admins can switch to anyone
    return true if current_user.super_admin?
    
    false
  end
end

