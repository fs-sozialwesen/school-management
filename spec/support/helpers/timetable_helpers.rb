module Features
  module TimetableHelpers

    def create_room(name, comments = nil)
      click_on 'Verwaltung'
      click_on 'Räume'
      click_on 'Neu'
      fill_in :Name, with: name
      fill_in :Bemerkungen, with: comments if comments
      click_on 'Speichern'
      expect(page).to have_content('Raum gespeichert')
    end
    alias :given_room :create_room

    def create_subject(name, comments = nil)
      click_on 'Verwaltung'
      click_on 'Fächer'
      click_on 'Neu'
      fill_in :Name, with: name
      fill_in :Bemerkungen, with: comments if comments
      click_on 'Speichern'
      expect(page).to have_content('Fach gespeichert')
    end
    alias :given_subject :create_subject

    def create_time_block(start_time, end_time)
      click_on 'Verwaltung'
      click_on 'Zeitblöcke'
      click_on 'Neu'
      fill_in :Beginn, with: start_time
      fill_in :Ende, with: end_time
      click_on 'Speichern'
      expect(page).to have_content('Zeitblock gespeichert')
    end
    alias :given_time_block :create_time_block


  end
end
