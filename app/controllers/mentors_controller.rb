class MentorsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_mentor, only: [:show, :edit, :update, :destroy]

  def index
    authorize Mentor
    @mentors = Mentor.all
  end

  def show
  end

  def new
    authorize Mentor
    @mentor = Mentor.new
  end

  def edit
  end

  def create
    authorize Mentor
    @mentor = Mentor.new mentor_params

    if @mentor.save
      redirect_to @mentor, notice: t(:created, model: Mentor.model_name.human)
    else
      render :new
    end
  end

  def update
    if @mentor.update mentor_params
      redirect_to @mentor, notice: t(:updated, model: Mentor.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @mentor.update archived: true
    redirect_to @mentor, notice: t(:archived, model: Mentor.model_name.human)
  end

  def toggle_archived
    @mentor = Mentor.find(params[:mentor_id])
    authorize @mentor
    @mentor.update(archived: !@mentor.archived)
    redirect_to @mentor, notice: t(:archived, model: Mentor.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mentor
    @mentor = Mentor.find params[:id]
    authorize @mentor
  end

  # Only allow a trusted parameter "white list" through.
  def mentor_params
    params.require(:mentor).permit(
      :id, :first_name, :last_name, :gender, :organisation_id, :qualified,
      address: %i(street zip city), contact: %i(email phone mobile)
    )
  end
end
