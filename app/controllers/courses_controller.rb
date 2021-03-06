class CoursesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_course, only: [:show, :edit, :update, :destroy, :generate_logins]

  def reset_db_id
    authorize Course
    ActiveRecord::Base.connection.reset_pk_sequence!(Course.table_name)
  end

  def index
    authorize Course
    @courses = Course.includes(:students, :time_tables, teacher: :person).order(:name)
    respond_to do |format|
      format.html do
        @active_courses = @courses.active.all
        @inactive_courses = @courses.inactive.all
      end
      format.xlsx  { @courses = @courses.all }
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
      redirect_to @course, notice: t(:created, model: Course.model_name.human)
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: t(:updated, model: Course.model_name.human)
    else
      render :edit
    end
  end

  def generate_logins
    @students = @course.students.includes(:login).order(:last_name).where('logins.id' => nil)
    return if request.get?
    errors = generate_logins_for(@students)
    if errors.any?
      messages = errors.map { |l| "#{l.user.name}: #{l.errors.full_messages.join('. ')}" }
      redirect_to @course, alert: t('.error', messages: messages.join(' '))
    else
      redirect_to @course, notice: t(:success, model: Course.model_name.human)
    end
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

  def generate_logins_for(students)
    students.each_with_object([]) do |student, errors|
      login = LoginGenerator.(email: student.contact.email, user: student)
      errors << login unless login.valid?
    end
  end

end
