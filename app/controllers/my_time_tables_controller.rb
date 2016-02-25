class MyTimeTablesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized

  def index
    authorize TimeTable
    @time_table = policy_scope(TimeTable).find_by(start_date: Date.current.beginning_of_week)
    @time_table = policy_scope(TimeTable).last unless @time_table
    redirect_to my_time_table_url(@time_table)
  end

  def show
    @time_tables = policy_scope(TimeTable).order(start_date: :desc).limit(10).all
    @time_table = TimeTable.includes(lessons: [:subject, :room, teacher: :person]).find(params[:id])
    authorize @time_table
    @time_blocks = TimeBlock.all
  end
end
