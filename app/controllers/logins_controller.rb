class LoginsController < ApplicationController
  before_action :authenticate_login!
  before_action :set_person
  after_action :verify_authorized

  def new
    @login = @person.build_login email: @person.contact.email
    authorize @login
  end

  def create
    authorize Login
    @login = LoginGenerator.new(@person, email: login_params[:email]).call

    if @login.valid?
      redirect_to @person, notice: t(:created, model: Login.model_name.human)
    else
      render 'new'
    end
  end

  def destroy
    login = @person.login
    authorize login
    login.destroy
    redirect_to @person, notice: t('.success')
  end

  def toggle
    login = @person.login
    authorize login
    login.toggle!
    redirect_to @person, notice: ( login.account_active? ? t('.activated') : t('.deactivated') )
  end

  private

  def set_person
    @person = Person.find params[:person_id]
  end

  def login_params
    params.require(:login).permit(:id, :email, :password, :password_confirmation)
  end

end
