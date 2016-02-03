module Features
  module CourseHelpers
    def create_course(attributes)
      teacher = attributes.delete :Klassenlehrer
      first_name, last_name = teacher.split ' '
      create_teacher Vorname: first_name, Nachname: last_name, Anrede: 'Herr'

      click_on 'Klassen'
      click_on 'Neu'
      attributes.each { |name, value| fill_in name, with: value }
      select teacher, from: :Klassenlehrer
      click_on 'Speichern'

      expect(page).to have_content 'Klasse gespeichert'
      attributes.values.each { |value| expect(page).to have_content value }
      click_on 'Liste'
    end
  end
end
