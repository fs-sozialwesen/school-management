class LoginsController < ApplicationController
  before_action :authenticate_login!
  before_action :set_teacher, except: :index
  after_action :verify_authorized

  def index
    @logins = Login.all
    authorize Login
  end

  def show
    @login = @person.login
    authorize @login
  end

  def new
    @login = @person.build_login email: @person.contact.email
    authorize @login
  end

  def create
    authorize Login
    @login = @person.build_login login_params
    if @login.save
      redirect_to @teacher, notice: t('.success')
    else
      render 'new'
    end
  end

  def edit
    @login = @person.login
  end

  def update
    @login = Login.find(params[:id])
    authorize @login
    if @login.update_attributes(login_params)
      redirect_to logins_path, :notice => "Login updated."
    else
      redirect_to logins_path, :alert => "Unable to update login."
    end
  end

  def destroy
    login = @person.login
    authorize login
    login.destroy
    redirect_to @teacher, :notice => "Login deleted."
  end

  private

  def set_teacher
    @teacher = Teacher.find params[:teacher_id]
    @person = @teacher.person
  end

  def login_params
    params.require(:login).permit(:email, :password, :password_confirmation)
  end

end
