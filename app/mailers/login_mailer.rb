class LoginMailer < ApplicationMailer

  def create_password_email(login, password)
    @login = login
    @password = password
    mail(to: @login.email, subject: t('.subject'))
  end

end
