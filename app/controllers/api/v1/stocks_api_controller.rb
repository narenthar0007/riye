class Api::V1::StocksApiController < Api::V1::BaseApiController
  require_permissions 'stocks'
  before_action :set_stock, only: [:show, :update]

  def index
    @stocks = Stock.all
    render json: @stocks.as_json(include: [:company, :project])
  end

  def show
    render json: @stock.as_json(include: [:company, :project])
  end

  def update
    if @stock.update(stock_params)
      render json: @stock.as_json(include: [:company, :project]), status: :ok
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:name, :quantity, :unit, :company_id, :project_id)
  end
end