class LoginGenerator

  attr_reader :person, :email, :password

  def initialize(person, email: nil, password: nil)
    @person   = person
    @email    = email ? email : person.contact.email
    @password = password ? password : generate_password
  end

  def call(confirm: true, send_email: true)
    return if person.login.present?
    login = person.create_login email: email, password: password, password_confirmation: password
    if login.valid?
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
