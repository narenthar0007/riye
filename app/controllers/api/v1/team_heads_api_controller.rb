class Api::V1::TeamHeadsApiController < Api::V1::BaseApiController
  require_permissions 'team_heads'
  before_action :set_team_head, only: [:show, :update]

  def index
    @team_heads = TeamHead.includes(:teams)
    render json: @team_heads.as_json(include: :teams)
  end

  def show
    render json: @team_head.as_json(include: :teams)
  end

  def update
    if @team_head.update(team_head_params)
      render json: @team_head.as_json(include: :teams), status: :ok
    else
      render json: @team_head.errors, status: :unprocessable_entity
    end
  end

  private

  def set_team_head
    @team_head = TeamHead.find(params[:id])
  end

  def team_head_params
    params.require(:team_head).permit(:name, :dob, :age, :gender, :address, :aadhaar_number, :contact_number)
  end
end