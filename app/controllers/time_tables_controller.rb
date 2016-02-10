class TimeTablesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_time_table, only: [:show, :edit, :update, :destroy]

  def index
    authorize TimeTable
    @time_tables = TimeTable.all
  end

  def show
    @time_blocks = TimeBlock.all
  end

  def new
    authorize TimeTable
    @time_table = TimeTable.new
  end

  def edit
    @time_blocks = TimeBlock.all
    @teachers = Teacher.all
    @subjects = Subject.all
    @rooms = Room.all
  end

  def create
    authorize TimeTable
    @time_table = TimeTable.new time_table_params

    TimeBlock.all.each do |time_block|
      1.upto(5).each do |weekday|
        @time_table.lessons.build time_block: time_block, weekday: weekday
      end
    end

    if @time_table.save
      redirect_to @time_table, notice: t(:created, model: TimeTable.model_name.human)
    else
      render :new
    end
  end

  def update
    if @time_table.update time_table_params
      redirect_to @time_table, notice: t(:updated, model: TimeTable.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @time_table.destroy
    redirect_to time_tables_url, notice: t(:destroyed, model: TimeTable.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_time_table
    @time_table = TimeTable.includes(:lessons).find params[:id]
    authorize @time_table
  end

  # Only allow a trusted parameter "white list" through.
  def time_table_params
    params.require(:time_table).permit(:course_id, :start_date, :comments, lessons_attributes:
      %i(id weekday time_block_id teacher_id subject_id room_id comments )
    )
  end
end
