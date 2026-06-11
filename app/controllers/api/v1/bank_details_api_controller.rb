class Api::V1::BankDetailsApiController < Api::V1::BaseApiController
  require_permissions 'bank_details'
  before_action :set_bank_detail, only: [:show, :update]

  def index
    @bank_details = BankDetail.includes(:worker)
    render json: @bank_details.as_json(include: :worker)
  end

  def show
    render json: @bank_detail.as_json(include: :worker)
  end

  def update
    if @bank_detail.update(bank_detail_params)
      render json: @bank_detail.as_json(include: :worker), status: :ok
    else
      render json: @bank_detail.errors, status: :unprocessable_entity
    end
  end

  private

  def set_bank_detail
    @bank_detail = BankDetail.find(params[:id])
  end

  def bank_detail_params
    params.require(:bank_detail).permit(:name_of_beneficiary, :account_number, :bank_name, :ifsc_code, :branch_name)
  end
end