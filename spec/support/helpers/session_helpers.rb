module Features
  module SessionHelpers

    def sign_in(email, password)
      visit new_login_session_path
      fill_in Login.human_attribute_name(:email),    with: email
      fill_in Login.human_attribute_name(:password), with: password
      click_button I18n.t('devise.sessions.new.sign_in')
    end

    def sign_out
      click_on @current_user.name, match: :first
      click_on 'Abmelden'
    end

    def sign_in_as_manager
      @current_user = manager = FactoryGirl.create(:person)
      manager.create_as_manager!
      sign_in(manager.login.email, '12341234')
      manager
    end

    def sign_in_as_student
      @current_user = student = FactoryGirl.create(:student)
      # student.create_as_student! student.attributes.slice('first_name', 'last_name')
      sign_in(student.login.email, '12341234')
      student
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
