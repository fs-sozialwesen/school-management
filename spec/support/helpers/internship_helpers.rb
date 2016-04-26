module Features
  module InternshipHelpers
    def create_organisation(name = nil)
      name ||= "Orga #{rand.to_s[-5..-1]}"
      click_on 'Träger'
      click_on 'Neu'
      fill_in :Name, with: name
      click_on 'Speichern'
      expect(page).to have_content(name)
      click_on 'Träger'
    end
    alias :given_organisation :create_organisation

    def create_institution(name, orga: nil)
      orga ||= "Carrier for #{name}"
      create_organisation orga
      click_on 'Einrichtungen'
      click_on 'Neu'
      fill_in :Name, with: name
      select orga, from: 'Träger'
      click_on 'Speichern'
      expect(page).to have_content('Einrichtung gespeichert')
      expect(page).to have_content(name)
      click_on 'Einrichtungen'
    end
    alias :given_institution :create_institution

    def create_internship(institution_name:)
      create_student Vorname: 'Sabine', Nachname: 'Neumann', Anrede: 'Frau',
                         'E-Mail-Adresse' => 'sabine@email.com'
      create_institution institution_name
      click_on 'Praktika'
      click_on 'Neu'
      select 'Sabine Neumann', from: 'internship[student_id]'
      select institution_name, from: 'Einrichtung'
      select Enum.internship_blocks.first, from: 'Praxisblock'
      fill_in :Beginn, with: '1.1.2016'
      fill_in :Ende, with: '31.3.2016'
      click_on 'Speichern'
      expect(page).to have_content('Praktikum gespeichert')
      expect(page).to have_content(institution_name)
      click_on 'Praktikum'
    end
    alias :given_internship :create_internship
  end
end
