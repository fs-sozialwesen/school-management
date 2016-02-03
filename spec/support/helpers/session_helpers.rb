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
      # save_and_open_page
      click_button I18n.t('devise.sessions.new.sign_in')
    end

    def sign_in_as_manager
      manager = FactoryGirl.create(:person)
      manager.create_as_manager!
      signin(manager.login.email, '12341234')
    end

    def signin_login(login)
      signin login.email, login.password
    end

    def signin_person(person)
      signin_login person.login
    end

    def signin_role(role)
      signin_login role.person.login
    end

    def click_on_any(text)
      page.find(:xpath, "//*[normalize-space()='#{text}']").click
    end

    def find_table_row(text)
      page.find(:xpath, "//td[normalize-space()='#{text}']/..")
    end
  end
end
