class LoginsController < ApplicationController
  before_action :authenticate_login!
  before_action :set_person, except: :index
  after_action :verify_authorized
  after_action :send_password_email, only: :create

  def new
    @login = @person.build_login email: @person.contact.email
    authorize @login
  end

  def create
    authorize Login
    @password = generate_password
    login_attributes = login_params.merge(password: @password, password_confirmation: @password)
    @login = @person.build_login login_attributes

    if @login.save
      redirect_to @role, notice: t('.success')
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
      redirect_to @role, notice: t('.success')
    else
      render :edit
      # redirect_to logins_path, :alert => "Unable to update login."
    end
  end

  def destroy
    login = @person.login
    authorize login
    login.destroy
    redirect_to @role, notice: t('.success')
  end

  private

  def set_person
    @role = role
    @person = @role.person
  end

  def role
    if params[:teacher_id].present?
      Teacher.find params[:teacher_id]
    elsif params[:student_id].present?
      Student.find params[:student_id]
    end
  end

  def login_params
    params.require(:login).permit(:email, :password, :password_confirmation)
  end

  def generate_password
    SecureRandom.hex(8)
  end

  def send_password_email
    if @login.valid?
      @login.confirm
      LoginMailer.create_password_email(@login, @password).deliver_later
    end
  end

end
