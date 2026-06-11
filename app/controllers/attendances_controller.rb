class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy, :approve]
  def approve
    @attendance.update(approved: true)
    redirect_to attendances_path, notice: 'Attendance edit approved.'
  end

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
      
      # Group workers by team heads for hierarchical display
      @team_heads_with_workers = {}
      @today_attendance_by_worker = {}
      
      # Get all team heads
      TeamHead.includes(teams: :workers).each do |team_head|
        workers_in_teams = team_head.teams.flat_map(&:workers)
        
        if workers_in_teams.any?
          @team_heads_with_workers[team_head] = workers_in_teams
          
          # Get attendance for each worker
          workers_in_teams.each do |worker|
            att = worker.attendances.where(created_at: today.beginning_of_day..today.end_of_day).first
            att ||= worker.attendances.build(created_at: Time.current)
            @today_attendance_by_worker[worker.id] = att
          end
        end
      end
      
      # Handle workers not assigned to any team head
      workers_without_team_head = Worker.left_joins(team: :team_head).where(team_heads: { id: nil })
      if workers_without_team_head.any?
        @unassigned_workers = workers_without_team_head
        workers_without_team_head.each do |worker|
          att = worker.attendances.where(created_at: today.beginning_of_day..today.end_of_day).first
          att ||= worker.attendances.build(created_at: Time.current)
          @today_attendance_by_worker[worker.id] = att
        end
      end
    end
  end

  def show; end

  def new
    @attendance = Attendance.new
  end

  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      redirect_to attendances_path, notice: 'Attendance was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @attendance.update(attendance_params)
      redirect_to attendances_path, notice: 'Attendance was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @attendance.destroy
    redirect_to attendances_url, notice: 'Attendance was successfully destroyed.'
  end

  private
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end
    def attendance_params
      params.require(:attendance).permit(:punch_in, :punch_out, :worker_id, :punch_in_location, :punch_out_location, :approved)
    end
end
