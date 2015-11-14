class LoginsController < ApplicationController
  before_action :authenticate_login!
  after_action :verify_authorized

  def index
    @logins = Login.all
    authorize Login
  end

  def show
    @login = Login.find(params[:id])
    authorize @login
  end

  def update
    @login = Login.find(params[:id])
    authorize @login
    if @login.update_attributes(secure_params)
      redirect_to logins_path, :notice => "Login updated."
    else
      redirect_to logins_path, :alert => "Unable to update login."
    end
  end

  def destroy
    login = Login.find(params[:id])
    authorize login
    login.destroy
    redirect_to logins_path, :notice => "Login deleted."
  end

  private

  def secure_params
    params.require(:login).permit(:role)
  end

end
