feature 'Manage subjects', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete subjects
#   So I can use them in timetables

  scenario 'create subject' do
    sign_in_as_manager

    click_on 'Fächer'
    click_on 'Neu'
    click_on 'Speichern'
    expect(page).to have_content('Das Fach konnte nicht gespeichert werden')
    create_subject 'Mathematics'
    click_on 'Fächer'
    expect(page).to have_content('Mathematics')
  end

  scenario 'edit subject' do
    sign_in_as_manager
    given_subject 'Mathematics'

    click_on 'Fächer'
    click_row_with 'Mathematics'
    fill_in :Name, with: ''
    click_on 'Speichern'
    expect(page).to have_content('Das Fach konnte nicht gespeichert werden')
    fill_in :Name, with: 'English'
    fill_in :Bemerkung, with: 'bring your books'
    click_on 'Speichern'
    expect(page).to have_content('Fach gespeichert')
    expect(page).to have_content('English')
    expect(page).to have_content('bring your books')
  end

  scenario 'delete subject' do
    sign_in_as_manager
    given_subject 'Mathematics'

    click_on 'Fächer'
    click_row_with 'Mathematics'
    click_on 'Löschen'
    expect(page).to have_content('Fach gelöscht')
  end
end
