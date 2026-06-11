class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.includes(:team_head, :workers).order(:name)
  end

  def show
  end

  def new
    @team = Team.new
    @team_heads = TeamHead.all
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to @team, notice: 'Team was successfully created.'
    else
      @team_heads = TeamHead.all
      render :new
    end
  end

  def edit
    @team_heads = TeamHead.all
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      @team_heads = TeamHead.all
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_url, notice: 'Team was successfully deleted.'
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :nature_of_skill, :team_head_id)
  end
end
