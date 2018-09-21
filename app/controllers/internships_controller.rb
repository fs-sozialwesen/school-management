class InternshipsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_internship, only: [:show, :edit, :update, :destroy]

  def index
    authorize Internship
    @internships = Internship.includes(student: :person, institution: :organisation, mentor: :person).
      order('people.last_name').all
  end

  def show
  end

  def new
    authorize Internship
    options           = {}
    options[:student] = Student.find params[:student_id] #if params[:student_id].present?
    @internship       = Internship.new options
    @students         = Student.order(:first_name, :last_name)
  end

  def edit
  end

  def create
    authorize Internship
    @internship = Internship.new internship_params

    if @internship.save
      redirect_to @internship, notice: t(:created, model: Internship.model_name.human)
    else
      render :new
    end
  end

  def update
    if @internship.update internship_params
      redirect_to @internship, notice: t(:updated, model: Internship.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @internship.destroy
    redirect_to internships_url, notice: t(:destroyed, model: Internship.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_internship
    @internship = Internship.find params[:id]
    authorize @internship
  end

  # Only allow a trusted parameter "white list" through.
  def internship_params
    params[:internship].delete :organisation
    params.require(:internship).permit(
      :student_id, :institution_id, :mentor_id, :internship_block_id, :contract_proved, :comments, :exchange
    )
  end

end
