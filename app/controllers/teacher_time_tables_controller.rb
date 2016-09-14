class TeacherTimeTablesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized

  def index
    authorize TimeTable
    redirect_to teacher_time_table_url(id: Date.current.beginning_of_week)
  end

  def show
    authorize TimeTable
    teacher              = current_user.as_teacher
    @date                = Date.parse params[:id]
    @lessons             = teacher.lessons_at @date
    @weeks               = teacher.time_table_dates
    @time_blocks         = TimeBlock.order(:start_time).all
    @timetable_documents = TimetableDocument.order(:year, :start_date).all
  end

end
