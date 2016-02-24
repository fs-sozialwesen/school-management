feature 'Manage rooms', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete rooms
#   So I can use them in timetables

  scenario 'create room' do
    sign_in_as_manager

    click_on 'Räume'
    click_on 'Neu'
    click_on 'Speichern'
    expect(page).to have_content('Der Raum konnte nicht gespeichert werden')
    create_room 'Room1'
    click_on 'Räume'
    expect(page).to have_content('Room1')
  end

  scenario 'edit room' do
    sign_in_as_manager
    given_room 'Room1'

    click_on 'Räume'
    click_row_with 'Room1'
    click_on 'Bearbeiten'
    fill_in :Name, with: ''
    click_on 'Speichern'
    expect(page).to have_content('Der Raum konnte nicht gespeichert werden')
    fill_in :Name, with: 'Room 42'
    fill_in :Bemerkung, with: 'Nice Room'
    click_on 'Speichern'
    expect(page).to have_content('Raum gespeichert')
    expect(page).to have_content('Room 42')
    expect(page).to have_content('Nice Room')
  end

  scenario 'delete room' do
    sign_in_as_manager
    given_room 'Room1'

    click_on 'Räume'
    click_row_with 'Room1'
    click_on 'Löschen'
    expect(page).to have_content('Raum gelöscht')
  end
end
