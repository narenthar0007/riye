class Api::V1::ProjectsApiController < Api::V1::BaseApiController
  require_permissions 'projects'
  before_action :set_project, only: [:show, :update]

  def index
    @projects = Project.includes(:company, :user).order(:start_date)
    render json: @projects.as_json(include: [:company, :user])
  end

  def show
    render json: @project.as_json(include: [:company, :user])
  end

  def update
    if @project.update(project_params)
      render json: @project.as_json(include: [:company, :user]), status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :location, :status, :company_id, :user_id, :start_date, :end_date, :customer_budget)
  end
end