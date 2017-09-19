feature 'Manage courses', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete courses
#   So I can keep the courses database up to date

  scenario 'create course' do
    sign_in_as_manager

    click_on 'Klassen'
    click_on 'Neu'
    click_on 'Speichern'
    expect(page).to have_content('Klasse konnte nicht gespeichert werden')
    
    create_course Name: 'Aktive Klasse', Klassenlehrer: 'Frank Meyer', Beginn: '01.01.2014', Ende: '01.01.2017'
  end

  scenario 'edit course' do
    sign_in_as_manager
    create_course Name: 'Aktive Klasse', Klassenlehrer: 'Frank Meyer', Beginn: '01.01.2014', Ende: '01.01.2017'
    create_teacher Vorname: 'Sabine', Nachname: 'Strohmann', Anrede: 'Frau'

    click_on 'Klassen'
    click_row_with 'Aktive Klasse'
    click_on 'Bearbeiten'
    fill_in :Name, with: 'Klasse Aktuell'
    fill_in :Beginn, with: ''
    click_on 'Speichern'
    expect(page).to have_content('Klasse konnte nicht gespeichert werden')
    fill_in :Beginn, with: '5.3.2013'
    click_on 'Speichern'
    expect(page).to have_content('Klasse gespeichert')
    expect(page).to have_content('Frank Meyer')

    click_on 'Bearbeiten'
    select 'Sabine Strohmann', from: :Klassenlehrer
    expect(page).to have_content('Sabine Strohmann')
  end

  scenario 'create logins for all students in course' do
    sign_in_as_manager
    create_course Name: 'Aktive Klasse', Klassenlehrer: 'Frank Meyer', Beginn: '01.01.2014', Ende: '01.01.2017'
    create_student Vorname: 'Sabine', Nachname: 'Neumann', Anrede: 'Frau', Klasse: 'Aktive Klasse', 'E-Mail-Adresse' => 'sabine@email.com'
    create_student Vorname: 'Frank',  Nachname: 'Meyer',   Anrede: 'Herr', Klasse: 'Aktive Klasse', 'E-Mail-Adresse' => 'frank@email.com'
    create_student Vorname: 'Clara',  Nachname: 'Schanz',  Anrede: 'Frau', Klasse: 'Aktive Klasse'

    click_on 'Klassen'
    click_row_with 'Aktive Klasse'
    click_on 'Login für alle erstellen'
    expect(page).to have_content('Logins generieren für Klasse Aktive Klasse')
    expect(page).to have_content('keine E-Mail-Adresse')

    click_on 'Logins erstellen'
    expect(page).to have_content('Aktive Klasse')
    expect(page).to have_content(
      'Es konnten nicht alle Logins für diese Klasse erstellt werden. Clara Schanz: E-Mail muss ausgefüllt werden')
  end
end
