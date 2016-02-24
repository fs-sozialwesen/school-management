# InternshipPositionsController
class InternshipPositionsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :process_filter_params, only: :index
  before_action :set_internship_position, only: [:show, :edit, :update, :destroy]
  before_action :authorize_internship_position

  def index
    @internship_positions = filter(internship_positions)
    respond_to do |format|
      format.html do
        @cities     = @internship_positions.all.map { |ip| ip.address.city }.compact.uniq.sort
        @work_areas = Enum.work_areas
        # @education_subjects   = EducationSubject.all
      end
      format.csv { }
    end
  end

  def show
  end

  def new
    @internship_position = InternshipPosition.new
  end

  def create
    @internship_position = InternshipPosition.new internship_position_params
    if @internship_position.save
      redirect_to @internship_position, notice: t('.success')
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @internship_position.update(internship_position_params)
      redirect_to @internship_position, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @internship_position.destroy
    redirect_to InternshipPosition, notice: t('.success')
  end

  private

  def internship_position_params
    params.require(:internship_position).permit(
      :name, :organisation_id, :description,
      applying: %i(by_phone by_mail by_email documents),
      housing: %i(provided costs),
      contact: %i(person email phone fax mobile homepage),
      address: %i(street zip city)
    )
  end

  def process_filter_params
    # filter_params = %i(education_subject_id city housing applying_by work_area)
    filter_params = %i(city housing applying_by work_area)
    filter_params.each { |filter| params.delete filter } if params[:submit] == 'clear'
    # @education_subject_id = params[:education_subject_id]
    @city                 = params[:city]
    @work_area            = params[:work_area]
  end

  def set_internship_position
    @internship_position = InternshipPosition.find params[:id]
    # authorize @internship_position
  end

  def authorize_internship_position
    authorize(@internship_position || InternshipPosition)
  end

  def housing
    @housing ||= { 'yes' => true, 'no' => false }[params[:housing]]
  end

  def applying_by
    apply_mapping = { mail: :by_mail, email: :by_email, phone: :by_phone }.stringify_keys
    @applying_by ||= apply_mapping[params[:applying_by]]
  end

  def internship_positions
    policy_scope(InternshipPosition).joins(:organisation).includes(:organisation)
      .order(:name)
      # .order("internship_positions.address->>'city'")
  end

  def filter(ips)
    ips = ips.by_city(@city)                                     if @city.present?
    # ips = ips.where(education_subject_id: @education_subject_id) if @education_subject_id.present?
    ips = ips.where(work_area: @work_area)                       if @work_area.present?
    ips = ips.housing(housing)                                   if housing.present?
    ips = ips.applying_by(applying_by)                           if applying_by.present?
    ips
  end
end
