class Api::V1::AttendancesApiController < Api::V1::BaseApiController
  require_permissions 'attendances'
  before_action :set_attendance, only: [:show, :update]

  def index
    filter = params[:filter]
    case filter
    when 'week'
      start_date = Date.today.beginning_of_week
      end_date = Date.today.end_of_week
      @attendances = Attendance.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    when 'month'
      start_date = Date.today.beginning_of_month
      end_date = Date.today.end_of_month
      @attendances = Attendance.where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    else
      today = Date.today
      @attendances = Attendance.where(created_at: today.beginning_of_day..today.end_of_day)
    end

    render json: @attendances.as_json(include: :worker)
  end

  def show
    render json: @attendance.as_json(include: :worker)
  end

  def update
    if @attendance.update(attendance_params)
      render json: @attendance.as_json(include: :worker), status: :ok
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  private

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:punch_in, :punch_out, :worker_id, :punch_in_location, :punch_out_location, :approved)
  end
end