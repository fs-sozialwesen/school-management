class LoginsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized

  def new
    raise 'unpermitted user type' unless params[:user_type].in? %w(Student Person)
    @login = Login.new params.permit(:user_type, :user_id)
    @login.generate_password = true
    @login.email = @login.user.contact.email
    authorize @login
  end

  def create
    @login = LoginGenerator.(login_params)
    authorize Login

    if @login.valid?
      redirect_to @login.user, notice: t(:created, model: Login.model_name.human)
    else
      render 'new'
    end
  end

  def destroy
    @login = Login.find params[:id]
    authorize @login
    @login.destroy
    redirect_to @login.user, notice: t('.success')
  end

  def toggle
    @login = Login.find params[:id]
    authorize @login
    @login.toggle!
    redirect_to @login.user, notice: ( @login.account_active? ? t('.activated') : t('.deactivated') )
  end

  private

  def login_params
    params.require(:login).permit(:email, :password, :password_confirmation, :user_type, :user_id, :generate_password)
  end

end
