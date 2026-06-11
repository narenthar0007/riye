class TeamHeadsController < ApplicationController
  before_action :set_team_head, only: [:show, :edit, :update, :destroy]

  def index
    @team_heads = TeamHead.includes(:teams).order(:name)
  end

  def show
  end

  def new
    @team_head = TeamHead.new
  end

  def create
    @team_head = TeamHead.new(team_head_params)

    if @team_head.save
      redirect_to @team_head, notice: 'Team Head was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @team_head.update(team_head_params)
      redirect_to @team_head, notice: 'Team Head was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @team_head.destroy
    redirect_to team_heads_url, notice: 'Team Head was successfully deleted.'
  end

  private

  def set_team_head
    @team_head = TeamHead.find(params[:id])
  end

  def team_head_params
    params.require(:team_head).permit(:name, :dob, :age, :gender, :address, :aadhaar_number, :contact_number)
  end
end
