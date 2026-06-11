class WorkersController < ApplicationController
  before_action :set_worker, only: [ :show, :edit, :update, :destroy ]

  def index
    @workers = Worker.includes(:project, :team, :head_worker).all
  end

  def show; end

  def new
    @worker = Worker.new
  end

  def create
    @worker = Worker.new(worker_params)
    if @worker.save
      redirect_to @worker, notice: "Worker was successfully created."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @worker.update(worker_params)
      redirect_to @worker, notice: "Worker was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @worker.destroy
    redirect_to workers_url, notice: "Worker was successfully destroyed."
  end

  private
    def set_worker
      @worker = Worker.find(params[:id])
    end
    def worker_params
      params.require(:worker).permit(:name, :contact, :project_id, :head_worker_id, :team_id)
    end
end
