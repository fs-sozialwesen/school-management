module Features
  module InternshipHelpers
    def create_organisation(name)
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
  end
end
