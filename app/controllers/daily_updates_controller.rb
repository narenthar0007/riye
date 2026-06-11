class DailyUpdatesController < ApplicationController
  before_action :set_daily_update, only: [:show, :edit, :update, :destroy, :approve]

  def index
    @daily_updates = DailyUpdate.all
  end

  def show; end

  def new
    @daily_update = DailyUpdate.new
  end

  def create
    @daily_update = DailyUpdate.new(daily_update_params)
    @daily_update.user = current_user
    if @daily_update.save
      redirect_to @daily_update, notice: 'Daily update was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @daily_update.update(daily_update_params)
      redirect_to @daily_update, notice: 'Daily update was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @daily_update.destroy
    redirect_to daily_updates_url, notice: 'Daily update was successfully destroyed.'
  end
  
  def approve
    @daily_update.update(approved: true)
    redirect_to daily_updates_path, notice: 'Daily update was approved successfully.'
  end

  private
    def set_daily_update
      @daily_update = DailyUpdate.find(params[:id])
    end
    def daily_update_params
      params.require(:daily_update).permit(:note)
    end
end
