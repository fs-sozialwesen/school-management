class LoginGenerator

  def self.call(login_params)
    login = Login.new login_params
    login.password = login.password_confirmation = generate_password if login.generate_password?
    if login.save
      login.confirm
      LoginMailer.create_password_email(login, login.password).deliver_now if login.generate_password?
    end
    login
  end

  def self.generate_password
    SecureRandom.hex(8)
  end
end
