class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user_context
  before_action :authorize_user_access!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user_action!, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.accessible_by(current_user).order(:email)
    @can_create_users = current_user.can_create_users?
  end

  def show
  end

  def new
    authorize_create_user!
    @user = User.new
    @available_roles = available_roles_for_creation
  end

  def create
    authorize_create_user!
    @user = User.new(user_params)
    @available_roles = available_roles_for_creation
    
    # Set current user context for validation
    User.current = current_user
    
    if @user.save
      redirect_to @user, notice: "User '#{@user.email}' was successfully created with #{@user.role_display} role."
    else
      render :new, status: :unprocessable_entity
    end
  ensure
    User.current = nil
  end

  def edit
  end

  def update
    # Set current user context for validation
    User.current = current_user
    
    old_role = @user.role
    
    if @user.update(user_params)
      if old_role != @user.role
        old_role_display = old_role&.humanize || 'Unknown'
        redirect_to @user, notice: "User '#{@user.email}' role was successfully updated from #{old_role_display} to #{@user.role_display}."
      else
        redirect_to @user, notice: 'User was successfully updated.'
      end
    else
      render :edit, status: :unprocessable_entity
    end
  ensure
    User.current = nil
  end

  def destroy
    user_email = @user.email
    @user.destroy
    redirect_to users_url, notice: "User '#{user_email}' was successfully deleted."
  end

  private

  def set_current_user_context
    User.current = current_user
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user_access!
    unless current_user.can_edit_users? || current_user == @user
      redirect_to root_path, alert: 'Access denied. You do not have permission to manage users.'
    end
  end

  def authorize_user_action!
    case action_name
    when 'show'
      # Allow users to view their own profile, otherwise check edit permissions
      unless current_user == @user || current_user.can_edit_users?
        redirect_to root_path, alert: 'Access denied. You cannot view this user.'
      end
    when 'edit', 'update'
      unless current_user.can_edit_user?(@user)
        redirect_to @user, alert: 'Access denied. You cannot edit this user.'
      end
    when 'destroy'
      unless current_user.can_delete_user?(@user)
        redirect_to users_path, alert: 'Access denied. You cannot delete this user.'
      end
    end
  end

  def authorize_create_user!
    unless current_user.can_create_users?
      redirect_to users_path, alert: 'Access denied. Only admins and owners can create new users.'
    end
  end

  def available_roles_for_creation
    roles = []
    
    # Everyone who can create users can create employees
    roles << ['Employee', 'employee']
    roles << ['Manager', 'manager']
    
    # Only super admins can create admins
    if current_user.super_admin?
      roles << ['Administrator', 'admin']
    end
    
    # Only owners can create other owners
    if current_user.owner?
      roles << ['Owner', 'owner']
    end
    
    roles
  end

  def user_params
    permitted_params = [:email]
    
    # Password fields for user creation
    if action_name == 'create'
      permitted_params += [:password, :password_confirmation]
    end
    
    # Role assignment based on permissions
    if current_user.can_create_users?
      # Filter allowed roles based on user permissions
      if params[:user][:role].present?
        requested_role = params[:user][:role]
        allowed_roles = available_roles_for_creation.map(&:last)
        
        if allowed_roles.include?(requested_role)
          permitted_params << :role
        end
      end
    end
    
    params.require(:user).permit(permitted_params)
  end
end
