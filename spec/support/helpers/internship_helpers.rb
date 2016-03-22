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

    def create_internship_position(name, orga: nil)
      orga ||= "Carrier for #{name}"
      create_organisation orga
      click_on 'Praktikumsplätze'
      click_on 'Neu'
      fill_in :Name, with: name
      select orga, from: 'Träger'
      click_on 'Speichern'
      expect(page).to have_content('Praktikumsplatz gespeichert')
      expect(page).to have_content(name)
      click_on 'Praktikumsplätze'
    end
    alias :given_internship_position :create_internship_position

    def create_internship(internship_position_name:)
      create_student Vorname: 'Sabine', Nachname: 'Neumann', Anrede: 'Frau',
                         'E-Mail-Adresse' => 'sabine@email.com'
      create_internship_position internship_position_name
      click_on 'Praktika'
      click_on 'Neu'
      # select 'Sabine Neumann', from: 'Auszubildende(r)'
      select 'Sabine Neumann', from: 'internship[student_id]'
      select internship_position_name, from: 'Praktikumsplatz'
      fill_in :Beginn, with: '1.1.2016'
      fill_in :Ende, with: '31.3.2016'
      click_on 'Speichern'
      expect(page).to have_content('Praktikum gespeichert')
      expect(page).to have_content(internship_position_name)
      click_on 'Praktikum'
    end
    alias :given_internship :create_internship
  end
end
