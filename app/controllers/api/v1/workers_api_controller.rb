class Api::V1::WorkersApiController < Api::V1::BaseApiController
  require_permissions 'workers'
  before_action :set_worker, only: [:show, :update]

  def index
    @workers = Worker.includes(:project, :team, :head_worker)
    render json: @workers.as_json(include: [:project, :team, :head_worker])
  end

  def show
    render json: @worker.as_json(include: [:project, :team, :head_worker])
  end

  def update
    if @worker.update(worker_params)
      render json: @worker.as_json(include: [:project, :team, :head_worker]), status: :ok
    else
      render json: @worker.errors, status: :unprocessable_entity
    end
  end

  private

  def set_worker
    @worker = Worker.find(params[:id])
  end

  def worker_params
    params.require(:worker).permit(:name, :contact, :project_id, :head_worker_id, :team_id)
  end
end