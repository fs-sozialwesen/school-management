feature 'Manage organisations', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete internship_positions
#   So I can use them in timetables

  scenario 'create organisation' do
    sign_in_as_manager

    create_organisation 'Träger1'
  end

  scenario 'edit organisation' do
    sign_in_as_manager
    given_organisation 'Träger1'

    click_on 'Träger'
    click_row_with 'Träger1'
    click_on 'Bearbeiten'
    fill_in :Name, with: ''
    click_on 'Speichern'
    expect(page).to have_content('Träger konnte nicht gespeichert werden')
    fill_in :Name, with: 'Träger 42'
    click_on 'Speichern'
    expect(page).to have_content('Träger gespeichert')
    expect(page).to have_content('Träger 42')
  end

  scenario 'delete organisation' do
    sign_in_as_manager
    given_organisation 'Träger1'

    click_on 'Träger'
    click_row_with 'Träger1'
    click_on 'Löschen'
    expect(page).to have_content('Träger gelöscht')
  end
end
