feature 'Manage managers', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete managers
#   So I can keep the managers database up to date

  scenario 'full roundtrip' do
    sign_in_as_manager

    create_manager Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'

    # edit created manager
    click_row_with 'Frank'
    click_on 'Bearbeiten'
    select 'Herr',            from: 'Anrede'
    fill_in 'Vorname',        with: ''
    fill_in 'Geburtsdatum',   with: '1.1.1996'
    fill_in 'PLZ',            with: '12345'
    fill_in 'E-Mail-Adresse', with: 'a@b.c'
    fill_in 'Telefon',        with: '09876'
    fill_in 'Mobiltelefon',   with: '01234567'
    click_on 'Speichern'
    expect(page).to have_content 'Personendaten konnten nicht gespeichert werden'
    fill_in 'Vorname', with: 'Rodriges'
    fill_in 'Nachname', with: 'Gonzales'
    click_on 'Speichern'
    expect(page).to have_content 'Personendaten gespeichert'
    expect(page).to have_content 'Rodriges Gonzales'

    # delete manager
    click_on 'Liste'
    expect do
      click_row_with 'Rodriges'
      click_on 'Löschen'
    end.to change { page.all('tbody tr[data-url]').count }.by(-1)
    expect(page).to have_content 'gelöscht'
  end

  scenario 'create new manager' do
    sign_in_as_manager
    create_manager Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
  end

  scenario 'edit manager' do
    sign_in_as_manager
    click_on 'Manager'
    click_on_first_row
    expect(page).to have_content 'Manager'
    click_on 'Bearbeiten'
    fill_in 'Vorname',        with: ''
    fill_in 'Geburtsdatum',   with: '1.1.1996'
    fill_in 'PLZ',            with: '12345'
    fill_in 'E-Mail-Adresse', with: 'a@b.c'
    fill_in 'Telefon',        with: '09876'
    fill_in 'Mobiltelefon',   with: '01234567'
    click_on 'Speichern'
    expect(page).to have_content 'Personendaten konnten nicht gespeichert werden'
    fill_in 'Vorname', with: 'Rodriges'
    fill_in 'Nachname', with: 'Gonzales'
    click_on 'Speichern'
    expect(page).to have_content 'Personendaten gespeichert'
    expect(page).to have_content 'Rodriges Gonzales'
  end

  scenario 'delete other manager' do
    sign_in_as_manager
    create_manager Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
    expect do
      click_row_with 'Frank'
      click_on 'Löschen'
    end.to change { page.all('tbody tr[data-url]').count }.by(-1)
    expect(page).to have_content 'gelöscht'
  end

  scenario 'can not delete myself' do
    sign_in_as_manager
    click_on 'Manager'
    click_row_with @current_user.last_name
    click_on 'Löschen'
    expect(page).to have_content('nicht berechtigt')
  end

end
