# CandidatesController
class CandidatesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  def index
    authorize Candidate
    @statuses   = Candidate.statuses
    @years      = (1.year.ago.year..2.year.from_now.year).to_a
    @candidates = filtered_candidates.all
  end

  def show
    authorize Candidate
  end

  def new
    authorize Candidate
    @candidate = Candidate.new
    @candidate.options.date = Date.current
    @candidate.build_person
  end

  def edit
    authorize Candidate
  end

  def create
    authorize Candidate
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      redirect_to @candidate, notice: t('.success')
    else
      render :new
    end
  end

  def update
    authorize Candidate
    if @candidate.update(candidate_params)
      redirect_to @candidate, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    authorize Candidate
    @candidate.destroy
    redirect_to role_candidates_url, notice: t('.success')
  end

  def init
    authorize Candidate
    candidate = Candidate.find(params[:id])
    candidate.created!
    redirect_to candidate, notice: 'Bewerber zurückgesetzt!'
  end

  def approve
    authorize Candidate
    candidate = Candidate.find(params[:id])
    candidate.approved!
    redirect_to candidate, notice: 'Bewerber zugelassen!'
  end

  def invite
    authorize Candidate
    @candidate = Candidate.find(params[:id])
    return unless request.patch?
    @candidate.invited!
    redirect_to @candidate, notice: 'Bewerber eingeladen!'
  end

  def accept
    authorize Candidate
    candidate = Candidate.find(params[:id])
    candidate.accepted!
    redirect_to candidate, notice: 'Bewerber angenommen!'
  end

  def reject
    authorize Candidate
    candidate = Candidate.find(params[:id])
    candidate.rejected!
    redirect_to candidate, notice: 'Bewerber abgelehnt!'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_candidate
    @candidate = Candidate.includes(:person).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def candidate_params
    params.require(:candidate)
      .permit(
        person_attributes: %i(first_name last_name gender date_of_birth place_of_birth) +
                             [
                               address: %i(street zip city),
                               contact: %i(email phone mobile)
                             ],
        options: options_params
      )
  end

  def options_params
    %i(date notes education_subject year school_graduate police_certificate
       education_contract_sent education_contract_received internship_contract_sent
       internship_contract_received) +
      [
        school_graduate:     %i(graduate proved),
        profession_graduate: %i(graduate proved comments),
        # education_graduate:  %i(name proved address),
        internship1:         %i(institution months proved),
        internship2:         %i(institution months proved)
      ]
  end

  def process_filter_params
    # education_subject  = params[:education_subject]
    # @education_subject = education_subject.in?(@education_subjects) ? education_subject : nil
    @year   = params[:year].to_i.in?(@years) ? params[:year].to_i : nil
    @status = status
  end

  def filtered_candidates
    process_filter_params
    candidates = Candidate.order(:status).includes(:person)
    candidates = candidates.send status if status.in?(@statuses.keys)
    candidates = candidates.where(status: @statuses[status]) if status.in?(@statuses.keys)
    # condition  = { education_subject: @education_subject }.to_json
    # candidates = candidates.where('options @> ?', condition) if @education_subject
    candidates = candidates.where('options @> ?', { year: @year }.to_json) if @year
    candidates
  end

  def status
    params[:status].to_s
  end
end
