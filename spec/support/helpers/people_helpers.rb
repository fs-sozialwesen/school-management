module Features
  module PeopleHelpers

    def create_person(scope, attributes)
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
      course = attributes.delete :Klasse
      create_person 'Auszubildende', attributes do
        select course, from: 'person[as_student_attributes][course_id]'
      end
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
