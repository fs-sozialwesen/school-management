class StudentsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    authorize Student
    @course = (params[:course] || :active).to_sym
    @students = Student.includes(:course, :login).where(filter(@course))

    respond_to do |format|
      format.html { @students = @students.order('students.last_name') }
      format.csv  { @students = @students.order('courses.name, students.last_name') }
    end
  end

  def show
  end

  def new
    authorize Student
    @student = Student.new
  end

  def edit
  end

  def create
    authorize Student
    @student = Student.new student_params

    if @student.save
      redirect_to @student, notice: t(:created, model: Student.model_name.human)
    else
      render :new
    end
  end

  def update
    if @student.update student_params
      redirect_to @student, notice: t(:updated, model: Student.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: t(:destroyed, model: Student.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find params[:id]
    authorize @student
  end

  # Only allow a trusted parameter "white list" through.
  def student_params
    params.require(:student).permit(
      %i(id first_name last_name gender date_of_birth place_of_birth course_id) +
        [address: %i(street zip city), contact: %i(email phone mobile)]
    )
  end

  def filter(course)
    case course
    when :dropouts then { active: false }
    when :active   then { course: Course.active }
    when :archived then { course: Course.inactive }
    when :no       then { course: nil }
    else                {}
    end
  end
end
