class Role::CandidatesController < ApplicationController

  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  def index
    authorize Role::Candidate
    @candidates = Role::Candidate.includes(:person).all
  end

  def show
    authorize Role::Candidate
  end

  def new
    authorize Role::Candidate
    @candidate = Role::Candidate.new
    @candidate.build_person
  end

  def edit
    authorize Role::Candidate
  end

  def create
    authorize Role::Candidate
    @candidate = Role::Candidate.new(candidate_params)

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: t('.success') }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize Role::Candidate
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to @candidate, notice: t('.success') }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize Role::Candidate
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to role_candidates_url, notice: t('.success') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Role::Candidate.includes(:person).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require(:role_candidate).
        permit(
          person_attributes:   [
             :first_name, :last_name, :date_of_birth, :place_of_birth,
             address: %i[street zip city],
             contact: %i[email phone mobile]
           ],
          options: [
             :education_subject,
             :year,
             :school_graduate,
             :internship_proved,
             :police_certificate,
             :education_contract_sent,
             :education_contract_received,
             :internship_contract_sent,
             :internship_contract_received,
             school_graduate:     %i[graduate proved],
             profession_graduate: %i[graduate proved comments],
             education_graduate:  %i[name proved address],
          ]
      )
    end
end


