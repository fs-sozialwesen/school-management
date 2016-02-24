class TimeTablesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_course, only: [:index, :new, :create]
  before_action :set_time_table, only: [:show, :edit, :update, :destroy, :toggle]

  def index
    authorize TimeTable
    @time_tables = @course.time_tables
  end

  def new
    authorize TimeTable
    @time_table = @course.time_tables.build
  end

  def create
    authorize TimeTable
    @time_table = @course.time_tables.build time_table_params

    if @time_table.save
      redirect_to @time_table, notice: t(:created, model: TimeTable.model_name.human)
    else
      render :new
    end
  end

  def show
    @time_blocks = TimeBlock.all
  end

  def edit
    @time_blocks = TimeBlock.all
    @teachers = Teacher.all
    @subjects = Subject.all
    @rooms = Room.all
  end

  def update
    if @time_table.update time_table_params
      redirect_to @time_table, notice: t(:updated, model: TimeTable.model_name.human)
    else
      render :edit
    end
  end

  def toggle
    @time_table.toggle_active!
    msg = @time_table.active? ? t('.activated') : 'SP deaktiviert'
    redirect_to @time_table, notice: msg
  end

  def destroy
    @time_table.destroy
    redirect_to @time_table.course, notice: t(:destroyed, model: TimeTable.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.includes(:time_tables).find params[:course_id]
  end

  def set_time_table
    @time_table = TimeTable.includes(lessons: [:subject, :room, teacher: :person]).find params[:id]
    authorize @time_table
  end

  # Only allow a trusted parameter "white list" through.
  def time_table_params
    params.require(:time_table).permit(:start_date, :comments)
  end
end
