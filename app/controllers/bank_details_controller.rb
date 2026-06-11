class BankDetailsController < ApplicationController
  before_action :set_bank_detail, only: [:show, :edit, :update, :destroy]
  before_action :set_worker, only: [:new, :create]

  def index
    @bank_details = BankDetail.includes(:worker).order('workers.name')
  end

  def show
  end

  def new
    @bank_detail = @worker.build_bank_detail
  end

  def create
    @bank_detail = @worker.build_bank_detail(bank_detail_params)

    if @bank_detail.save
      redirect_to worker_path(@worker), notice: 'Bank details were successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @bank_detail.update(bank_detail_params)
      redirect_to worker_path(@bank_detail.worker), notice: 'Bank details were successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    worker = @bank_detail.worker
    @bank_detail.destroy
    redirect_to worker_path(worker), notice: 'Bank details were successfully deleted.'
  end

  private

  def set_bank_detail
    @bank_detail = BankDetail.find(params[:id])
  end

  def set_worker
    @worker = Worker.find(params[:worker_id]) if params[:worker_id]
  end

  def bank_detail_params
    params.require(:bank_detail).permit(:name_of_beneficiary, :account_number, :bank_name, :ifsc_code, :branch_name)
  end
end
