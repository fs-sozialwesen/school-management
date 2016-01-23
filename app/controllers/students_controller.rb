class StudentsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    authorize Student
    @students = Student.includes(:person, :course).order('people.last_name').all
  end

  def show
    session[:redirect_to] = url_for @student
  end

  def new
    @student = Student.new
    authorize @student
  end

  def edit
  end

  def create
    @student = Student.new(student_params)
    authorize @student

    if @student.save
      redirect_to @student, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
      authorize @student
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit( :course_id,
                                       person_attributes:
                                         %i(gender first_name last_name) +
                                           [ contact: %i(email phone mobile)]
      )
    end
end
