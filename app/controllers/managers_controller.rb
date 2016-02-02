class ManagersController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized
  before_action :set_manager, only: [:show, :edit, :update, :destroy]

  def index
    authorize Manager
    @managers = Person.managers.all
  end

  def show
  end

  def new
    if params[:person_id]
      @person_exists = true
      @person = Person.find params[:person_id]
      @manager = @person.build_as_manager
    else
      @manager = Manager.new
      @manager.build_person
    end
    authorize @manager
  end

  def edit
  end

  def create
    @manager = if params[:person_id]
      @person = Person.find params[:person_id]
      @person.build_as_manager
    else
      Manager.new(manager_params)
    end
    authorize @manager

    if @manager.save
      redirect_to @manager, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @manager.update(manager_params)
      redirect_to @manager, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @manager.destroy
    redirect_to managers_url, notice: t('.success')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manager
      @manager = Manager.find(params[:id])
      authorize @manager
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manager_params
      params.require(:manager).permit(person_attributes: person_params)
    end
end
