feature 'Manage students', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete teachers
#   So I can keep the teacher database up to date

  scenario 'full roundtrip' do
    sign_in_as_manager

    create_student 'Vorname' => 'Frank', 'Nachname' => 'Meyer', 'Anrede' => 'Herr'

    # edit created student
    click_table_row_with 'Frank'
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

    # delete student
    click_on 'Liste'
    expect do
      click_table_row_with 'Rodriges'
      click_on 'Löschen'
    end.to change { page.all('tbody tr[data-url]').count }.by(-1)
    expect(page).to have_content 'gelöscht'
  end


  scenario 'create new student' do
    sign_in_as_manager
    click_on 'Auszubildende'
    expect do
      create_student 'Vorname' => 'Frank', 'Nachname' => 'Meyer', 'Anrede' => 'Herr'
    end.to change { page.all('tbody tr[data-url]').count }.by(1)
    expect(page).to have_content 'Frank'
    expect(page).to have_content 'Meyer'
  end

  scenario 'edit student' do
    sign_in_as_manager
    create_student 'Vorname' => 'Frank', 'Nachname' => 'Meyer', 'Anrede' => 'Herr'
    click_table_row_with 'Frank'
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
  end

  scenario 'delete student' do
    sign_in_as_manager
    create_student 'Vorname' => 'Frank', 'Nachname' => 'Meyer', 'Anrede' => 'Herr'
    click_on 'Auszubildende'
    expect do
      click_table_row_with 'Frank'
      click_on 'Löschen'
    end.to change { page.all('tbody tr[data-url]').count }.by(-1)
    expect(page).to have_content 'gelöscht'
  end

end
