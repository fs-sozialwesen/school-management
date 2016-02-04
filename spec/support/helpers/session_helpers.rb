module Features
  module SessionHelpers

    def signin(email, password)
      visit new_login_session_path
      fill_in Login.human_attribute_name(:email),    with: email
      fill_in Login.human_attribute_name(:password), with: password
      click_button I18n.t('devise.sessions.new.sign_in')
    end

    def sign_out
      click_on 'Abmelden'
    end

    def sign_in_as_manager
      @current_user = manager = FactoryGirl.create(:person)
      manager.create_as_manager!
      signin(manager.login.email, '12341234')
    end

    def sign_in_as_student
      @current_user = student = FactoryGirl.create(:person)
      student.create_as_student!
      signin(student.login.email, '12341234')
    end

    # def signin_login(login)
    #   signin login.email, login.password
    # end

    # def signin_person(person)
    #   signin_login person.login
    # end

    # def signin_role(role)
    #   signin_login role.person.login
    # end
  end
end
