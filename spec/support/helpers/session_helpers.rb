module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit new_login_registration_path
      fill_in Login.human_attribute_name(:email),    with: email
      fill_in Login.human_attribute_name(:password), with: password
      fill_in Login.human_attribute_name(:password), :with => confirmation
      click_button I18n.t('devise.sessions.new.sign_out')
    end

    def signin(email, password)
      visit new_login_session_path
      fill_in Login.human_attribute_name(:email),    with: email
      fill_in Login.human_attribute_name(:password), with: password

      click_button I18n.t('devise.sessions.new.sign_in')
    end
  end
end
