class Api::V1::TeamsApiController < Api::V1::BaseApiController
  require_permissions 'teams'
  before_action :set_team, only: [:show, :update]

  def index
    @teams = Team.includes(:team_head, :workers)
    render json: @teams.as_json(include: [:team_head, :workers])
  end

  def show
    render json: @team.as_json(include: [:team_head, :workers])
  end

  def update
    if @team.update(team_params)
      render json: @team.as_json(include: [:team_head, :workers]), status: :ok
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :nature_of_skill, :team_head_id)
  end
end