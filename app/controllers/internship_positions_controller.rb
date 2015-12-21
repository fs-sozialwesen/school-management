# InternshipPositionsController
class InternshipPositionsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :process_filter_params, only: :index

  def index
    authorize InternshipPosition

    @internship_positions = filtered_internship_positions.all
    @cities               = @internship_positions.all.map { |ip| ip.address.city }.compact.uniq.sort
    @work_areas           = InternshipPosition.work_areas
    @education_subjects   = EducationSubject.all
  end

  def show
    @internship_position = InternshipPosition.find params[:id]
    authorize @internship_position
  end

  private

  def process_filter_params
    filter_params = %i(education_subject_id city housing applying_by work_area)
    filter_params.each { |filter| params.delete filter } if params[:submit] == 'clear'
    @education_subject_id = params[:education_subject_id]
    @city                 = params[:city]
    @work_area            = params[:work_area]
  end

  def housing
    @housing ||= { 'yes' => true, 'no' => false }[params[:housing]]
  end

  def applying_by
    apply_mapping = { mail: :by_mail, email: :by_email, phone: :by_phone }.stringify_keys
    @applying_by ||= apply_mapping[params[:applying_by]]
  end

  def filtered_internship_positions
    ips = policy_scope(InternshipPosition)
          .by_city(@city).housing(housing).applying_by(applying_by)
          .joins(:organisation)
          .includes(:organisation)
          .order("internship_positions.address->>'city'")
    ips = ips.where(work_area: @work_area) if @work_area.present?
    ips = ips.where(education_subject_id: @education_subject_id) if @education_subject_id.present?
    ips
  end
end
