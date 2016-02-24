class OrganisationsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_organisation, only: [:show, :edit, :update, :destroy]
  before_action :authorize_organisation

  def index
    @organisations = Organisation.order(:name).all
  end

  def show
  end

  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new organisation_params

    if @organisation.save
      redirect_to @organisation, notice: t(:created, model: Organisation.model_name.human)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organisation.update organisation_params
      redirect_to @organisation, notice: t(:updated, model: Organisation.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @organisation.destroy
    redirect_to organisations_url, notice: t(:destroyed, model: Organisation.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_organisation
    @organisation = Organisation.find params[:id]
  end

  def authorize_organisation
    authorize(@organisation || Organisation)
  end

  # Only allow a trusted parameter "white list" through.
  def organisation_params
    params.require(:organisation).permit(
      :name, :comments, 
      contact: %i(person email phone fax mobile homepage),
      address: %i(street zip city)
    )
  end
end
