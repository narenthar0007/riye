class Api::V1::BaseApiController < ApplicationController
  before_action :authenticate_api_key

  private

  def authenticate_api_key
    access_key = request.headers['X-API-Key'] || params[:api_key]
    secret_key = request.headers['X-API-Secret'] || params[:api_secret]

    unless access_key.present?
      render json: { error: 'API key is required' }, status: :unauthorized
      return
    end

    @api_access = ApiAccess.active.find_by(access_key: access_key)

    if @api_access.nil?
      render json: { error: 'Invalid API key' }, status: :unauthorized
      return
    end

    if secret_key.present? && @api_access.secret_key != secret_key
      render json: { error: 'Invalid API secret' }, status: :unauthorized
      return
    end

    if @api_access.expired?
      render json: { error: 'API key has expired' }, status: :unauthorized
      return
    end

    # Update last used timestamp
    @api_access.update_last_used

    # Check permissions if specified
    unless has_required_permissions?
      render json: { error: 'Insufficient permissions' }, status: :forbidden
      return
    end
  end

  def has_required_permissions?
    return true unless @api_access.permissions.present?

    required_permissions = self.class.required_permissions
    return true if required_permissions.blank?

    required_permissions.any? { |permission| @api_access.has_permission?(permission) }
  end

  def self.require_permissions(*permissions)
    @required_permissions = permissions
  end

  def self.required_permissions
    @required_permissions || []
  end
end