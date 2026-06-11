class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_update
  before_action :set_reply, only: [:destroy]

  def index
    # Redirect to the daily update show page where replies are displayed
    redirect_to @daily_update
  end

  def create
    @reply = @daily_update.replies.build(reply_params)
    @reply.user = current_user

    if @reply.save
      redirect_to @daily_update, notice: 'Reply was successfully created.'
    else
      redirect_to @daily_update, alert: 'Failed to create reply.'
    end
  end

  def destroy
    if @reply.user == current_user || current_user.can_edit_users?
      @reply.destroy
      redirect_to @daily_update, notice: 'Reply was successfully deleted.'
    else
      redirect_to @daily_update, alert: 'You are not authorized to delete this reply.'
    end
  end

  private

  def set_daily_update
    @daily_update = DailyUpdate.find(params[:daily_update_id])
  end

  def set_reply
    @reply = @daily_update.replies.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content, :image)
  end
end
