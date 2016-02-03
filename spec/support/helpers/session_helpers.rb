module Features
  module SessionHelpers

    def create_person(scope, attributes)
      click_on scope
      click_on 'Neu'
      attributes.each do |name, value|
        if name.in?(%w(Anrede))
          select value, from: name
        else
          fill_in name, with: value
        end
      end
      yield if block_given?
      click_on 'Speichern'
      expect(page).to have_content 'Personendaten gespeichert'
      attributes.values.each { |value| expect(page).to have_content value }
      click_on 'Liste'
    end

    def create_teacher(attributes)
      create_person 'Lehrer', attributes
    end

    def create_manager(attributes)
      create_person 'Manager', attributes
    end

    def create_student(attributes)
      create_person 'Auszubildende', attributes do
        select_course
      end
    end

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
      @current_user = manager = FactoryGirl.create(:person)
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
      find(:xpath, "//*[normalize-space()='#{text}']").click
    end

    def find_table_row(text)
      find(:xpath, "//td[normalize-space()='#{text}']/..")
    end

    def click_table_row_with(text)
      visit find_table_row(text)['data-url']
    end

    def click_on_first_row
      visit find('table.table-clickable > tbody  > tr:first-child')['data-url']
    end

    def select_course(scope = :active)
      option = case scope
      when :active   then 'optgroup[1]/option[2]'
      when :archived then 'optgroup[2]/option[2]'
      when :no       then 'option[1]'
      end
      find('.person_as_student_course select').find(:xpath, option).select_option
    end
  end
end
