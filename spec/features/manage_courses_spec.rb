feature 'Manage courses', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete courses
#   So I can keep the courses database up to date

  scenario 'create course' do
    sign_in_as_manager
    create_course Name: 'Aktive Klasse', Klassenlehrer: 'Frank Meyer',
                  Beginn: '01.01.2014', Ende: '01.01.2017'
  end

  scenario 'edit course' do
    sign_in_as_manager
    create_course Name: 'Aktive Klasse', Klassenlehrer: 'Frank Meyer',
                  Beginn: '01.01.2014', Ende: '01.01.2017'
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
end
