feature 'Manage students', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete teachers
#   So I can keep the teacher database up to date

  scenario 'full roundtrip' do
    sign_in_as_manager

    create_course Name: 'Active Course', Klassenlehrer: 'Frank Meyer',
                  Beginn: '01.01.2014', Ende: '01.01.2050'

    create_student Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr', Klasse: 'Active Course'

    # edit created student
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
    expect(page).to have_content 'Auszubildende*r konnte nicht gespeichert werden'
    fill_in 'Vorname', with: 'Rodriges'
    fill_in 'Nachname', with: 'Gonzales'
    click_on 'Speichern'
    expect(page).to have_content 'Auszubildende*r gespeichert'
    expect(page).to have_content 'Rodriges Gonzales'

    # delete student
    click_on 'Liste'
    expect do
      click_row_with 'Rodriges'
      click_on 'Löschen'
    end.to change { page.all('tbody tr[data-url]').count }.by(-1)
    expect(page).to have_content 'gelöscht'
  end


  scenario 'create new student' do
    sign_in_as_manager
    create_course Name: 'Active Course', Klassenlehrer: 'Frank Meyer',
                  Beginn: '01.01.2014', Ende: '01.01.2050'

    click_on 'Auszubildende'
    click_on 'Neu'
    click_on 'Speichern'
    expect(page).to have_content('Auszubildende*r konnte nicht gespeichert werden')

    click_on 'Auszubildende'
    expect do
      create_student Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr', Klasse: 'Active Course'
    end.to change { page.all('tbody tr[data-url]').count }.by(1)
    expect(page).to have_content 'Frank'
    expect(page).to have_content 'Meyer'
  end

  scenario 'edit student' do
    sign_in_as_manager
    create_course Name: 'Active Course', Klassenlehrer: 'Frank Meyer',
                  Beginn: '01.01.2014', Ende: '01.01.2050'

    create_student Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr', Klasse: 'Active Course'
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
    expect(page).to have_content 'Auszubildende*r konnte nicht gespeichert werden'
    fill_in 'Vorname', with: 'Rodriges'
    fill_in 'Nachname', with: 'Gonzales'
    click_on 'Speichern'
    expect(page).to have_content 'Auszubildende*r gespeichert'
    expect(page).to have_content 'Rodriges Gonzales'
  end

  scenario 'delete student' do
    sign_in_as_manager
    create_course Name: 'Active Course', Klassenlehrer: 'Frank Meyer',
                  Beginn: '01.01.2014', Ende: '01.01.2050'

    create_student Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr', Klasse: 'Active Course'
    expect do
      click_row_with 'Frank'
      click_on 'Löschen'
    end.to change { page.all('tbody tr[data-url]').count }.by(-1)
    expect(page).to have_content 'gelöscht'
  end

  scenario 'create login for student' do
    sign_in_as_manager
    create_course Name: 'Active Course', Klassenlehrer: 'Frank Meyer', Beginn: '01.01.2014', Ende: '01.01.2050'
    create_student Vorname: 'Frank', Nachname: 'Meyer', Anrede: 'Herr', Klasse: 'Active Course'

    click_row_with 'Frank'
    click_on 'Login erstellen'
    fill_in 'E-Mail', with: ''
    click_on 'Erstellen'
    expect(page).to have_content('Login konnte nicht gespeichert werden')

    fill_in 'E-Mail', with: 'test@email.de'
    click_on 'Erstellen'
    expect(page).to have_content('Login gespeichert')
    expect(page).to have_content('test@email.de')
    expect(page).to have_content('aktiv')
  end

  scenario 'activate and deactivate logins' do
    student = sign_in_as_student
    sign_out

    manager = sign_in_as_manager
    click_on 'Auszubildende'
    click_on 'ohne Klasse'
    click_row_with student.first_name
    click_on 'Deaktivieren'
    expect(page).to have_content('Login deaktiviert')
    expect(page).to have_content('deaktiviert am')
    sign_out

    sign_in student.login.email, '12341234'
    expect(page).to have_content('Dein Account ist gesperrt. Bitte wende dich an das Sekretariat')

    sign_in manager.login.email, '12341234'
    click_on 'Auszubildende'
    click_on 'ohne Klasse'
    click_row_with student.first_name
    click_on 'Aktivieren'
    expect(page).to have_content('Login aktiviert')
    expect(page).to have_content('aktiv')
    sign_out

    sign_in student.login.email, '12341234'
    expect(page).to have_content('Erfolgreich angemeldet.')

  end

end
