class InternshipPositionsController < ApplicationController

  before_action :authenticate_login!
  after_action :verify_authorized

  def index
    authorize InternshipPosition

    @internship_positions = filtered_internship_positions.all
    @cities               = @internship_positions.all.map { |ip| ip.address.city }.compact.uniq.sort
    @work_areas           = InternshipPosition.work_areas
  end

  def show
    @internship_position = InternshipPosition.find params[:id]
    authorize @internship_position
  end

  private

  def process_filter_params
    %i(city housing applying_by work_area).each { |filter| params.delete filter } if params[:submit] == 'clear'
    @city        = params[:city]
    @housing     = {'yes' => true, 'no' => false}[params[:housing]]
    @applying_by = {'mail' => :by_mail, 'email' => :by_email, 'phone' => :by_phone}[params[:applying_by]]
    @work_area   = params[:work_area]
  end

  def filtered_internship_positions
    process_filter_params
    ips = policy_scope(InternshipPosition).
      by_city(@city).
      housing(@housing).
      applying_by(@applying_by).
      joins(:organisation).
      includes(:organisation).
      order("internship_positions.address->>'city'")
    ips = ips.where(work_area: @work_area) if @work_area.present?
    ips
  end

end
