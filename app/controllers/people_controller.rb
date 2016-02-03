class PeopleController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_scope, only: [:new, :create]
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def managers
    authorize Person
    @managers = Person.managers.includes(:login).order(:last_name).all
  end

  def teachers
    authorize Person
    @teachers = Person.teachers.includes(:login, as_teacher: :courses).order(:last_name).all
  end

  def students
    authorize Person
    @students = Person.students.includes(:login, as_student: :course).order(:last_name)
    @archived = params[:archived].present?
    courses   = @archived ? Course.inactive : Course.active
    respond_to do |format|
      format.html { @students = @students.where('students.course_id' => courses).all }
      format.csv  { @students = @students.order('courses.name, last_name').all }
    end
  end

  def new
    @person = Person.new
    @person.send "build_as_#{@scope}"
    authorize @person
  end

  def create
    @person = Person.new(person_params)
    @person.send "build_as_#{@scope}"
    authorize @person

    if @person.save
      redirect_to @person, notice: t('.success')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @person.update(person_params)
      redirect_to @person, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to people_url, notice: t('.success')
  end

  private

  def set_scope
    @scope = params[:scope].to_sym
    raise StandardError, "unknown scope #{@scope}" unless @scope.in?(%i(manager teacher student))
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.includes(:as_manager, :as_teacher, :as_student).find(params[:id])
    authorize @person
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    permit = %i(id first_name last_name gender date_of_birth place_of_birth) + contact_params
    permit += [as_student_attributes: [:course_id]] if student?
    params.require(:person).permit(permit)
  end

  def contact_params
    [ address: %i(street zip city), contact: %i(email phone mobile) ]
  end

  def student?
    @scope == :student or (@person && @person.student?)
  end
end
