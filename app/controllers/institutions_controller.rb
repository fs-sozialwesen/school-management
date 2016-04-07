class InstitutionsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_institution, only: [:show, :edit, :update, :destroy]

  def index
    authorize Institution
    @institutions = Institution.includes(:organisation).order(:name).all

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def new
    authorize Institution
    @institution = Institution.new
    if params[:organisation_id].present?
      @institution.organisation = Organisation.find_by(id: params[:organisation_id])
    end
  end

  def create
    authorize Institution
    @institution = Institution.new institution_params

    if @institution.save
      redirect_to @institution, notice: t(:created, model: Institution.model_name.human)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @institution.update institution_params
      redirect_to @institution, notice: t(:updated, model: Institution.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @institution.destroy
    redirect_to institutions_url, notice: t(:destroyed, model: Institution.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_institution
    @institution = Institution.find params[:id]
    authorize @institution
  end

  # Only allow a trusted parameter "white list" through.
  def institution_params
    # params.require(:institution).permit(:organisation_id, :name, :description, :work_area, :start_date, :end_date, :positions_count, :address, :contact, :applying, :housing)
    params.require(:institution).permit(
      :name, :organisation_id, :description, :work_area, :in_search,
      applying: %i(by_phone by_mail by_email documents),
      housing: %i(provided costs),
      contact: %i(person email phone fax mobile homepage),
      address: %i(street zip city)
    )
  end
end
