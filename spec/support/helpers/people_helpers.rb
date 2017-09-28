module Features
  module PeopleHelpers

    def create_person(scope, attributes, i18n_scope: nil)
      i18n_scope ||= scope
      click_on 'Mitarbeiter'
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
      create_person 'Lehrer', attributes
    end
    alias :given_teacher :create_teacher

    def create_manager(attributes)
      create_person 'Manager', attributes
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
      expect(page).to have_content 'Auszubildende(r) gespeichert'
      attributes.values.each { |value| expect(page).to have_content value }
      click_on 'Liste'
    end
    alias :given_student :create_student

    def create_candidate(attributes)
      click_on 'Bewerber'
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
      expect(page).to have_content 'Bewerber(in) gespeichert'
      attributes.values.each { |value| expect(page).to have_content value }
      click_on 'Liste'
    end
  end
end
