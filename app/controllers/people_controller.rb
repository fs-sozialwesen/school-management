class PeopleController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    authorize Person
    @people = Person.includes(:as_teacher, :as_manager, :as_student).order(:last_name, :first_name).all
  end

  def show
    session.delete(:redirect_to)
  end

  def new
    @person = Person.new
    authorize @person
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    authorize @person

    if @person.save
      redirect_to @person, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @person.update(person_params)
      path = session.delete(:redirect_to) || @person
      redirect_to path, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to people_url, notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
      authorize @person
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(%i(first_name last_name gender date_of_birth place_of_birth) +
                                               [
                                                 address: %i(street zip city),
                                                 contact: %i(email phone mobile)
                                               ])
    end
end
