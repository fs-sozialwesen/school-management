feature 'Manage internship positions', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete internship_positions
#   So I can use them in timetables

  scenario 'create internship_position' do
    sign_in_as_manager

    create_internship_position 'Einrichtung1'
  end

  scenario 'edit internship_position' do
    sign_in_as_manager
    given_internship_position 'Einrichtung1'

    click_on 'Praktikumsplätze'
    click_on 'Einrichtung1'
    click_on 'Bearbeiten'
    fill_in :Name, with: ''
    click_on 'Speichern'
    expect(page).to have_content('Praktikumsplatz konnte nicht gespeichert werden')
    fill_in :Name, with: 'Einrichtung 42'
    click_on 'Speichern'
    expect(page).to have_content('Praktikumsplatz gespeichert')
    expect(page).to have_content('Einrichtung 42')
  end

  scenario 'delete internship_position' do
    sign_in_as_manager
    given_internship_position 'Einrichtung1'

    click_on 'Praktikumsplätze'
    click_on 'Einrichtung1'
    click_on 'Löschen'
    expect(page).to have_content('Praktikumsplatz gelöscht')
  end
end
