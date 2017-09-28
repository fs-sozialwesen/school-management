class LoginGenerator

  def self.call(user, email:, password: nil, confirm: true, send_email: true)
    password ||= generate_password
    login = user.build_login email: email, password: password, password_confirmation: password
    if login.save
      login.confirm if confirm
      LoginMailer.create_password_email(login, password).deliver_now if send_email
    end
    login
  end

  def self.generate_password
    SecureRandom.hex(8)
  end
end
