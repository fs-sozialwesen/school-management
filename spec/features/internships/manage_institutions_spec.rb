feature 'Manage institutions', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete institutions
#   So I can provide internship positions to the students

  scenario 'create institution' do
    sign_in_as_manager

    create_institution 'Einrichtung1'
  end

  scenario 'edit institution' do
    sign_in_as_manager
    given_institution 'Einrichtung1'

    click_on 'Einrichtungen'
    click_row_with 'Einrichtung1'
    click_on 'Bearbeiten'
    fill_in :Name, with: ''
    click_on 'Speichern'
    expect(page).to have_content('Einrichtung konnte nicht gespeichert werden')
    fill_in :Name, with: 'Einrichtung 42'
    click_on 'Speichern'
    expect(page).to have_content('Einrichtung gespeichert')
    expect(page).to have_content('Einrichtung 42')
  end

  scenario 'delete institution' do
    sign_in_as_manager
    given_institution 'Einrichtung1'

    click_on 'Einrichtungen'
    click_row_with 'Einrichtung1'
    click_on 'Löschen'
    expect(page).to have_content('Einrichtung gelöscht')
  end
end
