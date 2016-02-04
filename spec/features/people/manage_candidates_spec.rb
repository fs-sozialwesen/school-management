feature 'Manage candidates', :devise do
#   As a manager
#   I want to be able to add, edit and find candidates
#   So I can easily walk through the whole application process

  scenario 'create new candidate' do
    sign_in_as_manager
    click_on 'Bewerber'
    expect do
      create_candidate Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
    end.to change { page.all('tbody tr[data-url]').count }.by(1)
    expect(page).to have_content 'Frank'
    expect(page).to have_content 'Meyer'
  end

  scenario 'edit candidate' do
    sign_in_as_manager

    create_candidate Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
    click_row_with 'Frank'
    within('.panel', match: :first) { click_on 'Bearbeiten' }
    select 'Herr',            from: 'Anrede'
    fill_in 'Vorname',        with: ''
    fill_in 'Geburtsdatum',   with: '1.1.1996'
    fill_in 'PLZ',            with: '12345'
    fill_in 'E-Mail-Adresse', with: 'a@b.c'
    fill_in 'Telefon',        with: '09876'
    fill_in 'Mobiltelefon',   with: '01234567'
    click_on 'Speichern'
    expect(page).to have_content 'Bewerber konnte nicht gespeichert werden'
    fill_in 'Vorname', with: 'Rodriges'
    fill_in 'Nachname', with: 'Gonzales'
    click_on 'Speichern'
    expect(page).to have_content 'Bewerber(in) gespeichert'
    expect(page).to have_content 'Rodriges Gonzales'
  end

  scenario 'delete student' do
    sign_in_as_manager

    create_candidate Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
    expect do
      click_row_with 'Frank'
      click_on 'Löschen'
    end.to change { page.all('tbody tr[data-url]').count }.by(-1)
    expect(page).to have_content 'gelöscht'
  end

end
