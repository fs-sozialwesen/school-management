feature 'Manage organisations', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete internship_positions
#   So I can use them in timetables

  scenario 'create organisation' do
    sign_in_as_manager

    create_organisation 'Organisation1'
  end

  scenario 'edit organisation' do
    sign_in_as_manager
    given_organisation 'Organisation1'

    click_on 'Organisationen'
    click_row_with 'Organisation1'
    click_on 'Bearbeiten'
    fill_in :Name, with: ''
    click_on 'Speichern'
    expect(page).to have_content('Organisation konnte nicht gespeichert werden')
    fill_in :Name, with: 'Organisation 42'
    click_on 'Speichern'
    expect(page).to have_content('Organisation gespeichert')
    expect(page).to have_content('Organisation 42')
  end

  scenario 'delete organisation' do
    sign_in_as_manager
    given_organisation 'Organisation1'

    click_on 'Organisationen'
    click_row_with 'Organisation1'
    click_on 'Löschen'
    expect(page).to have_content('Organisation gelöscht')
  end
end
