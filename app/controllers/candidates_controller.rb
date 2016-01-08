# CandidatesController
class CandidatesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_candidate, except: [:index, :new, :create]

  def index
    authorize Candidate
    @statuses   = Candidate.statuses
    @years      = (1.year.ago.year..2.year.from_now.year).to_a
    @candidates = filtered_candidates.all
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

  def accept_interview
    @candidate.interview.accept!
    @candidate.save!
    redirect_to @candidate, notice: 'KLT positiv durchgeführt!'
  end

  def reject_interview
    @candidate.interview.reject!
    @candidate.save!
    redirect_to @candidate, notice: 'KLT abgelehnt!'
  end

  def repeat_interview
    @candidate.interview.repeat!
    @candidate.save!
    redirect_to edit_candidate_path(@candidate, part: 'interview'), notice: 'KLT zurückgesetzt'
  end

  def reject
    return unless request.patch?
    @candidate.rejected!
    redirect_to @candidate, notice: 'Bewerber abgelehnt!'
  end

  def cancel
    return unless request.patch?
    @candidate.canceled!
    redirect_to @candidate, notice: 'Bewerber abgelehnt!'
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
           internship_contract_received) +
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
