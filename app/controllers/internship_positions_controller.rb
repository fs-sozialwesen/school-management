# InternshipPositionsController
class InternshipPositionsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized

  def index
    authorize Institution
    process_filter_params
    @institutions = filter(institutions)
    @cities       = @institutions.all.map { |ip| ip.address.city }.compact.uniq.sort
    @work_areas   = Enum.work_areas
    # @education_subjects   = EducationSubject.all
  end

  def show
    @institution = Institution.find params[:id]
    authorize @institution
  end

  private

  def process_filter_params
    # filter_params = %i(education_subject_id city housing applying_by work_area)
    filter_params = %i(city housing applying_by work_area)
    filter_params.each { |filter| params.delete filter } if params[:submit] == 'clear'
    # @education_subject_id = params[:education_subject_id]
    @city      = params[:city]
    @work_area = params[:work_area]
  end

  def housing
    @housing ||= { 'yes' => true, 'no' => false }[params[:housing]]
  end

  def applying_by
    apply_mapping = { mail: :by_mail, email: :by_email, phone: :by_phone }.stringify_keys
    @applying_by ||= apply_mapping[params[:applying_by]]
  end

  def institutions
    policy_scope(Institution).joins(:organisation).includes(:organisation)
      .order(:name).where(in_search: true)
      # .order("institutions.address->>'city'")
  end

  def filter(institutions)
    # ips = ips.where(education_subject_id: @education_subject_id) if @education_subject_id.present?
    institutions = institutions.by_city(@city)               if @city.present?
    institutions = institutions.where(work_area: @work_area) if @work_area.present?
    institutions = institutions.housing(housing)             if housing.present?
    institutions = institutions.applying_by(applying_by)     if applying_by.present?
    institutions
  end
end
