class TeacherTimeTablesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized

  def index
    authorize TimeTable
    redirect_to teacher_time_table_url(id: Date.current.beginning_of_week)
  end

  def show
    authorize TimeTable
    @date                = Date.parse params[:id]
    @lessons             = current_user.as_teacher.lessons_at @date
    @weeks               = current_user.as_teacher.time_table_dates
    @time_blocks         = TimeBlock.all
    @timetable_documents = TimetableDocument.order(:year, :start_date).all
  end

end
