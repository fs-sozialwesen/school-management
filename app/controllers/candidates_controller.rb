# CandidatesController
class CandidatesController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_candidate, except: [:index, :new, :create]

  def index
    authorize Candidate
    @filter     = CandidatesFilter.new(params)
    @candidates = @filter.perform.all
    @grouped    = params[:view] == 'grouped'
    @years      = Candidate.select('DISTINCT year').order('year').map(&:year).compact
  end

  def show
  end

  def new
    authorize Candidate
    @candidate = Candidate.new
    @candidate.date = Date.current
  end

  def edit
  end

  def create
    authorize Candidate
    @candidate = Candidate.new(candidate_params)

    if @candidate.save
      redirect_to @candidate, notice: t(:created, model: Candidate.model_name.human)
    else
      render :new
    end
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to @candidate, notice: t(:updated, model: Candidate.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
    redirect_to candidates_url, notice: t(:destroyed, model: Candidate.model_name.human)
  end

  def accept
    @candidate.accept!
    redirect_to @candidate, notice: 'Bewerber*in aufgenommen!'
  end

  def reject
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_candidate
    @candidate = Candidate.find_by id: params[:id]
    authorize @candidate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def candidate_params
    params.require(:candidate)
      .permit(%i(first_name last_name gender date_of_birth place_of_birth
                 date notes education_subject year police_certificate internships cancel_date
                 internships_proved education_contract_sent education_contract_received
                 internship_contract_sent internship_contract_received cancel_reason status
                 debit_mandate contract_notes career_changer rank) +
                [
                  address: %i(street zip city),
                  contact: %i(email phone mobile),
                  school_graduate:     %i(graduate proved),
                  profession_graduate: %i(graduate proved comments),
                  interview:           %i(date time place comments invited answer result reason),
                ])
  end

end
