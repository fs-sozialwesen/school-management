class CoursesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    authorize Course
    @courses = Course.includes(:students).order(:name)
    respond_to do |format|
      format.html do
        @active_courses = @courses.active.all
        @inactive_courses = @courses.inactive.all
      end
      format.csv  { @courses = @courses.all }
    end
  end

  def show
  end

  def new
    @course = Course.new
    authorize @course
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    authorize @course

    if @course.save
      redirect_to @course, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_url, notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
      authorize @course
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :teacher_id, :start_date, :end_date)
    end
end
