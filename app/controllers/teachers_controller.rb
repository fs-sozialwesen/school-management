class TeachersController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  def index
    authorize Teacher
    @teachers = Teacher.includes(:courses, person: :login).order('people.last_name').all
  end

  def show
  end

  def new
    if params[:person_id]
      @person_exists = true
      @person = Person.find params[:person_id]
      @teacher = @person.build_as_teacher
    else
      @teacher = Teacher.new
      @teacher.build_person
    end
    authorize @teacher
  end

  def edit
  end

  def create
    @teacher = if params[:person_id]
      @person = Person.find params[:person_id]
      @person.build_as_teacher
    else
      Teacher.new(teacher_params)
    end

    authorize @teacher

    if @teacher.save
      redirect_to @teacher, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @teacher.update(teacher_params)
      redirect_to @teacher, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @teacher.destroy
    redirect_to teachers_url, notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
      authorize @teacher
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(person_attributes: person_params)
    end
end
