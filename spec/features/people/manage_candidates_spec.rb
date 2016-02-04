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

  scenario 'edit person data' do
    sign_in_as_manager

    create_candidate Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
    click_row_with 'Frank'
    within('.panel.person') { click_on 'Bearbeiten' }
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

  scenario 'edit documents' do
    sign_in_as_manager

    create_candidate Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
    click_row_with 'Frank'
    within('.panel.documents') { click_on 'Bearbeiten' }
    # save_and_open_page
    select 'Grade1', from: :Schulabschluss
    select 'Prof2', from: :Berufsausbildung
    click_on 'Speichern'
    expect(page).to have_content 'Bewerber(in) gespeichert'
  end

  scenario 'edit interview' do
    sign_in_as_manager

    create_candidate Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
    click_row_with 'Frank'
    within('.panel.interview') { click_on 'Bearbeiten' }
    fill_in 'Datum', with: '01.07.2016'
    check 'eingeladen'
    select 'Zusage', from: 'Rückmeldung'
    select 'Wiederholen', from: 'Ergebnis'
    click_on 'Speichern'
    expect(page).to have_content 'Bewerber(in) gespeichert'
    expect(page).to have_content '01.07.2016'
  end

  scenario 'edit contracts' do
    sign_in_as_manager

    create_candidate Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
    click_row_with 'Frank'
    within('.panel.contracts') { click_on 'Bearbeiten' }
    within('.panel.education-contract') do
      fill_in 'Versand am', with: '01.08.2016'
      fill_in 'zurück',     with: '03.08.2016'
    end
    within('.panel.internship-contract') do
      fill_in 'Versand am', with: '01.09.2016'
      fill_in 'zurück',     with: '03.09.2016'
    end
    click_on 'Speichern'
    expect(page).to have_content 'Bewerber(in) gespeichert'
    expect(page).to have_content '01.08.2016'
    expect(page).to have_content '03.08.2016'
    expect(page).to have_content '01.09.2016'
    expect(page).to have_content '03.09.2016'
  end

  scenario 'delete candidate' do
    sign_in_as_manager

    create_candidate Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr'
    expect do
      click_row_with 'Frank'
      click_on 'Löschen'
    end.to change { page.all('tbody tr[data-url]').count }.by(-1)
    expect(page).to have_content 'gelöscht'
  end

end
