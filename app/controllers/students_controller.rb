class StudentsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    authorize Student
    @students = Student.includes(:course, person: :login)
    respond_to do |format|
      format.html { @students = @students.order('people.last_name').all }
      format.csv  { @students = @students.order('courses.name, people.last_name').all }
    end
  end

  def show
  end

  def new
    @student = Student.new
    @student.build_person
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
      params.require(:student).permit(
        :course_id,
        person_attributes: %i(first_name last_name gender date_of_birth place_of_birth) +
                             [
                               address: %i(street zip city),
                               contact: %i(email phone mobile)
                             ],
      )
    end
end
