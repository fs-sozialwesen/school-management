class PeopleController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_scope, only: [:new, :create]
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :set_course_filter, only: :students

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
      .where(filter)
    respond_to do |format|
      format.html { @students = @students.all }
      format.csv  { @students = @students.order('courses.name, last_name').all }
    end
  end

  def mentors
    authorize Person
    @mentors = Person.mentors.includes(as_mentor: :organisation).order(:last_name)
    # respond_to do |format|
    #   format.html { @mentors = @mentors.where('students.course_id' => course_filter).all }
    #   format.csv  { @mentors = @mentors.order('courses.name, last_name').all }
    # end
  end

  def new
    @person = Person.new
    if @scope == :mentor && params[:organisation_id].present?
      @person.build_as_mentor organisation: Organisation.find(params[:organisation_id])
    else
      @person.send "build_as_#{@scope}"
    end
    authorize @person
  end

  def create
    @person = Person.new(person_params)
    @person.send "build_as_#{@scope}" unless @person.as(@scope).present?
    authorize @person

    if @person.save
      redirect_to @person, notice: t(:created, model: model_name)
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
      redirect_to @person, notice: t(:updated, model: model_name(@person))
    else
      render :edit
    end
  end

  def destroy
    if @person.destroy
      redirect_to view_context.index_path_for(@person), notice: t(:destroyed, model: model_name(@person))
    else
      redirect_to @person, flash: { error: t('.failed')}
    end
  end

  private

  def set_scope
    @scope = params[:scope].to_sym
    raise StandardError, "unknown scope #{@scope}" unless @scope.in?(%i(manager teacher student mentor))
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.includes(:as_manager, :as_teacher, :as_student).find(params[:id])
    authorize @person
  end

  def set_course_filter
    @course = params[:course].present? ? params[:course].to_sym : :active
  end

  def course_filter
    return Course.active   if @course == :active
    return Course.inactive if @course == :archived
    nil
  end

  def filter
    if @course == :dropouts
      { 'students.active' => false }
    else
      { 'students.course_id' => course_filter }
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    permit = %i(id first_name last_name gender date_of_birth place_of_birth) + contact_params
    permit += [as_student_attributes: [:id, :course_id]] #if student?
    permit += [as_mentor_attributes: [:id, :organisation_id]] #if mentor?
    params.require(:person).permit(permit)
  end

  def contact_params
    [ address: %i(street zip city), contact: %i(email phone mobile) ]
  end

  def model_name(person = nil)
    if person
      person.roles.first.class
    else
      @scope.to_s.classify.constantize
    end.model_name.human
  end
  # def student?
  #   @scope == :student or (@person && @person.student?)
  # end
end
