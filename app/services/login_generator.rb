class LoginGenerator

  attr_reader :user, :email, :password, :login

  def initialize(user, email: nil, password: nil)
    @user     = user
    @email    = email || user.contact.email
    @password = password || generate_password
    @login    = user.build_login email: email, password: password, password_confirmation: password
  end

  def persist(confirm: true, send_email: true)
    return if user.login.present?
    # login = user.create_login email: email, password: password, password_confirmation: password
    if login.save
      login.confirm if confirm
      LoginMailer.create_password_email(login, password).deliver_now if send_email
    end
    login
  end

  private

  def generate_password
    SecureRandom.hex(8)
  end
end
