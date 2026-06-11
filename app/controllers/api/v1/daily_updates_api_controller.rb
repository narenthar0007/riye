class Api::V1::DailyUpdatesApiController < Api::V1::BaseApiController
  require_permissions 'daily_updates'
  before_action :set_daily_update, only: [:show, :update]

  def index
    @daily_updates = DailyUpdate.all
    render json: @daily_updates.as_json(include: :user)
  end

  def show
    render json: @daily_update.as_json(include: :user)
  end

  def update
    if @daily_update.update(daily_update_params)
      render json: @daily_update.as_json(include: :user), status: :ok
    else
      render json: @daily_update.errors, status: :unprocessable_entity
    end
  end

  private

  def set_daily_update
    @daily_update = DailyUpdate.find(params[:id])
  end

  def daily_update_params
    params.require(:daily_update).permit(:note)
  end
end