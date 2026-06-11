class Api::V1::RepliesApiController < Api::V1::BaseApiController
  require_permissions 'replies'
  before_action :set_reply, only: [:show, :update]

  def index
    @replies = Reply.all
    render json: @replies.as_json(include: [:daily_update, :user])
  end

  def show
    render json: @reply.as_json(include: [:daily_update, :user])
  end

  def update
    if @reply.update(reply_params)
      render json: @reply.as_json(include: [:daily_update, :user]), status: :ok
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  private

  def set_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end