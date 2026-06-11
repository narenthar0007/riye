class ApiAccessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_api_access, only: [:show, :edit, :update, :destroy]

  def index
    @api_accesses = ApiAccess.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @api_access = ApiAccess.new
  end

  def create
    @api_access = ApiAccess.new(api_access_params)
    @api_access.user = current_user if params[:api_access][:user_id].blank?

    if @api_access.save
      redirect_to api_accesses_path, notice: 'API access key was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @api_access.update(api_access_params)
      redirect_to api_accesses_path, notice: 'API access key was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @api_access.destroy
    redirect_to api_accesses_path, notice: 'API access key was successfully deleted.'
  end

  private

  def set_api_access
    @api_access = ApiAccess.find(params[:id])
  end

  def api_access_params
    params.require(:api_access).permit(:name, :permissions, :user_id, :expires_at, :active, :access_key, :secret_key)
  end
end