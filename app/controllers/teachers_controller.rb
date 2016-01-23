class TeachersController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  def index
    authorize Teacher
    @teachers = Teacher.includes(:person, :courses).order('people.last_name').all
  end

  def show
    session[:redirect_to] = url_for @teacher
  end

  def new
    @teacher = Teacher.new
    authorize @teacher
    @teacher.build_person
  end

  def edit
  end

  def create
    @teacher = Teacher.new(teacher_params)
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
      params.require(:teacher).permit(
        person_attributes: %i(gender first_name last_name) + [ contact: %i(email phone mobile) ]
      )
    end
end
