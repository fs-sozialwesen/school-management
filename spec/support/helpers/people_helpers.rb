module Features
  module PeopleHelpers

    def create_person(scope, attributes, i18n_scope: nil)
      i18n_scope ||= scope
      click_on 'Mitarbeiter*innen'
      click_on scope
      click_on 'Neu'
      attributes.each do |name, value|
        if name.in?(%i(Anrede))
          select value, from: name
        else
          fill_in name, with: value
        end
      end
      yield if block_given?
      click_on 'Speichern'
      expect(page).to have_content "#{i18n_scope} gespeichert"
      attributes.values.each { |value| expect(page).to have_content value }
      click_on 'Liste'
    end

    def create_teacher(attributes)
      create_person 'Lehrer*innen', attributes, i18n_scope: 'Lehrer*in'
    end
    alias :given_teacher :create_teacher

    def create_manager(attributes)
      create_person 'Manager*innen', attributes, i18n_scope: 'Manager*in'
    end
    alias :given_manager :create_manager

    def create_student(attributes)
      course = attributes.delete :Klasse

      click_on 'Auszubildende'
      click_on 'Neu'
      attributes.each do |name, value|
        if name.in?(%i(Anrede))
          select value, from: name
        else
          fill_in name, with: value
        end
      end
      select course, from: 'student[course_id]'
      click_on 'Speichern'
      expect(page).to have_content 'Auszubildende*r gespeichert'
      attributes.values.each { |value| expect(page).to have_content value }
      click_on 'Liste'
    end
    alias :given_student :create_student

    def create_candidate(attributes)
      click_on 'Bewerber*innen'
      click_on 'Neu'
      attributes.each do |name, value|
        if name.in?(%i(Anrede))
          select value, from: name
        else
          fill_in name, with: value
        end
      end
      yield if block_given?
      click_on 'Speichern'
      expect(page).to have_content 'Bewerber*in gespeichert'
      attributes.values.each { |value| expect(page).to have_content value }
      click_on 'Liste'
    end

    # def select_course(scope = :active)
    #   option = case scope
    #   when :active   then 'optgroup[1]/option[2]'
    #   when :archived then 'optgroup[2]/option[2]'
    #   when :no       then 'option[1]'
    #   end
    #   find('.person_as_student_course select').find(:xpath, option).select_option
    # end
  end
end
