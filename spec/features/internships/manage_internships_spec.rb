feature 'Manage internships', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete internships
#   So I have all the time the overview

  scenario 'create internship' do
    skip
    sign_in_as_manager

    create_internship institution_name: 'Einrichtung1'
  end

  scenario 'edit internship' do
    skip
    sign_in_as_manager
    given_internship institution_name: 'Einrichtung1'

    click_on 'Praktika'
    click_row_with 'Einrichtung1'
    click_on 'Bearbeiten'
    fill_in :Beginn, with: ''
    click_on 'Speichern'
    expect(page).to have_content('Praktikum konnte nicht gespeichert werden')
    fill_in :Beginn, with: '1.1.2016'
    click_on 'Speichern'
    expect(page).to have_content('Praktikum gespeichert')
    expect(page).to have_content('Einrichtung1')
  end

  scenario 'delete internship' do
    skip
    sign_in_as_manager
    given_internship institution_name: 'Einrichtung1'

    click_on 'Praktika'
    click_row_with 'Einrichtung1'
    click_on 'Löschen'
    expect(page).to have_content('Praktikum gelöscht')
  end
end
