# CandidatesController
class CandidatesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_candidate, except: [:index, :new, :create]

  def index
    authorize Candidate
    @statuses   = Candidate.statuses
    @candidates = filtered_candidates.all
    @grouped = params[:view] == 'grouped'
  end

  def show
  end

  def new
    authorize Candidate
    @candidate = Candidate.new
    @candidate.date = Date.current
    @candidate.build_person
  end

  def edit
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
    if @candidate.update(candidate_params)
      redirect_to @candidate, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
    redirect_to candidates_url, notice: t('.success')
  end

  def init
    @candidate.created!
    redirect_to @candidate, notice: 'Bewerber zurückgesetzt!'
  end

  def accept
    @candidate.accepted!
    redirect_to candidate_url(@candidate), notice: 'Bewerber aufgenommen!'
  end

  def reject
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_candidate
    @candidate = Candidate.includes(:person).find(params[:id])
    authorize @candidate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def candidate_params
    params.require(:candidate)
      .permit(

        %i(date notes education_subject year police_certificate internships internships_proved
           education_contract_sent education_contract_received internship_contract_sent
           internship_contract_received cancel_date cancel_reason status) +
          [
            school_graduate:     %i(graduate proved),
            profession_graduate: %i(graduate proved comments),
            interview:           %i(date time place comments invited answer result reason),
            internship1:         %i(institution months proved),
            internship2:         %i(institution months proved),
            person_attributes: %i(first_name last_name gender date_of_birth place_of_birth) +
                                         [
                                           address: %i(street zip city),
                                           contact: %i(email phone mobile)
                                         ],
          ]
      )
  end

  def process_filter_params
    @status = status
    @invited = { 'yes' => true, 'no' => false }[params[:interview_invited]]
    @answer = params[:interview_answer]
    @result = params[:interview_result]
  end

  def filtered_candidates
    process_filter_params
    candidates = Candidate.order(:date).includes(:person)
    candidates = candidates.send status if status.in?(@statuses.keys)
    candidates = candidates.where(status: @statuses[status]) if status.in?(@statuses.keys)
    candidates = candidates.where('interview @> ?', { invited: @invited }.to_json) if @invited.in?([true, false])
    candidates = candidates.where('interview @> ?', { answer: @answer }.to_json) if @answer.present?
    candidates = candidates.where('interview @> ?', { result: @result }.to_json) if @result.present?
    candidates
  end

  def status
    params[:status].to_s
  end
end
