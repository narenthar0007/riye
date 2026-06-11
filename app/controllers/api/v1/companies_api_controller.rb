class Api::V1::CompaniesApiController < Api::V1::BaseApiController
  require_permissions 'companies'
  before_action :set_company, only: [:show, :update]

  def index
    @companies = Company.all
    render json: @companies
  end

  def show
    render json: @company
  end

  def update
    if @company.update(company_params)
      render json: @company, status: :ok
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name)
  end
end