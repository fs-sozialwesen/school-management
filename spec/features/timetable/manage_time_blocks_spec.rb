feature 'Manage time blocks', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete rooms
#   So I can use them in timetables

  scenario 'create time block' do
    sign_in_as_manager

    click_on 'Zeitblöcke'
    click_on 'Neu'
    click_on 'Speichern'
    expect(page).to have_content('Der Zeitblock konnte nicht gespeichert werden')
    create_time_block '09:15', '10:45'
    click_on 'Zeitblöcke'
    expect(page).to have_content('09:15')
  end

  scenario 'edit time block' do
    sign_in_as_manager
    given_time_block '09:15', '10:45'

    click_on 'Zeitblöcke'
    click_row_with '09:15 - 10:45'
    click_on 'Bearbeiten'
    fill_in :Beginn, with: ''
    click_on 'Speichern'
    expect(page).to have_content('Der Zeitblock konnte nicht gespeichert werden')
    fill_in :Beginn, with: '2:33'
    fill_in :Ende, with: '17:57'
    click_on 'Speichern'
    expect(page).to have_content('Zeitblock gespeichert')
    expect(page).to have_content('2:33')
    expect(page).to have_content('17:57')
  end

  scenario 'delete time block' do
    sign_in_as_manager
    given_time_block '09:15', '10:45'

    click_on 'Zeitblöcke'
    click_row_with '09:15 - 10:45'
    click_on 'Löschen'
    expect(page).to have_content('Zeitblock gelöscht')
  end
end
