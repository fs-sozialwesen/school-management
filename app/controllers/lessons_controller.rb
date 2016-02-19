class LessonsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_lesson, only: [:update, :edit, :destroy]
  before_action :set_time_table, only: [:new, :create]

  layout false

  def new
    lesson = params.permit :time_block_id, :weekday
    @lesson = @time_table.lessons.build lesson
    authorize @lesson
  end

  def create
    @lesson = @time_table.lessons.build lesson_params
    authorize @lesson
    if @lesson.save
      render_time_table_body @time_table
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lesson.update lesson_params
      render_time_table_body @lesson.time_table
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy
    if @lesson.destroyed?
      render_time_table_body @lesson.time_table
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:time_block_id, :weekday, :subject_id, :teacher_id, :room_id, :comments )
  end

  def set_time_table
    @time_table = TimeTable.find params[:time_table_id]
  end

  def set_lesson
    @lesson = Lesson.find params[:id]
    authorize @lesson
  end

  def render_time_table_body(time_table)
    locals = { time_table: time_table, time_blocks: TimeBlock.all }
    render partial: 'time_tables/table_body', locals: locals
  end
end
