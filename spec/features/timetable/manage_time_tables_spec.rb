feature 'Manage time tables', :devise do
#   As a manager
#   I want to be able to add, edit and activate time tables for classes
#   So that the students can see their time table

  scenario 'create time table', js: true do
    # skip # heisenbug on codeship
    student = sign_in_as_student
    sign_out
    # click_on student.name
    # click_on 'Abmelden'
    manager = sign_in_as_manager

    given_room 'Room1'
    given_room 'Room2'
    given_subject 'Mathe'
    given_subject 'Sport'
    given_time_block '08:00', '09:00'
    given_time_block '10:00', '11:00'

    given_course Name: 'Klasse 5a', Klassenlehrer: 'Frank Meyer',
                  Beginn: '01.01.2014', Ende: '01.01.2017'
    given_teacher Vorname: 'Sabine', Nachname: 'Strohmann', Anrede: 'Frau'
    given_teacher Vorname: 'John', Nachname: 'Meier', Anrede: 'Herr'

    click_on 'Klassen'
    click_row_with 'Klasse 5a'

    click_on 'Stundenpläne'
    click_on 'Neu'
    click_on 'Speichern'
    expect(page).to have_content('Der Stundenplan konnte nicht gespeichert werden')
    fill_in :Woche, with: '05.05.2016'
    click_on 'Speichern'
    expect(page).to have_content('Stundenplan gespeichert')
    # click_on 'Stundenpläne'
    expect(page).to have_content('02.05. - 06.05.')

    click_on 'Klasse 5a'
    click_on 'Stundenpläne'
    expect(page).to have_content('Mo 02.05 - Fr 06.05')

    click_row_with 'Mo 02.05 - Fr 06.05'

    # add a lesson
    click_on 'Neue Stunde', match: :first
    select 'Mathe', from: 'Fach'
    select 'John Meier', from: 'Lehrer'
    click_on 'Speichern'
    expect(page).to have_content('J. Meier')
    expect(page).to have_content('Mathe')

    # edit a lesson
    click_on 'Mathe', match: :first
    select '', from: 'Fach'
    click_on 'Speichern'
    expect(page).to have_content('muss ausgefüllt werden')
    select 'Mathe', from: 'Fach'
    fill_in :Bemerkungen, with: 'aaaa'
    click_on 'Speichern'
    expect(page).to have_content('aaaa')
    expect(page).to have_content('Mathe')

    # add a lesson with room and comments
    click_on 'Neue Stunde', match: :first
    # save_and_open_page
    # binding.pry
    select 'Sport', from: 'Fach'
    select 'Sabine Strohmann', from: 'Lehrer'
    select 'Room1', from: 'Raum'
    fill_in :Bemerkungen, with: 'Remember'
    click_on 'Speichern'
    expect(page).to have_content('S. Strohmann')
    expect(page).to have_content('Sport')
    expect(page).to have_content('Room1')
    expect(page).to have_content('Remember')

    # copy a lesson
    click_on 'Stunde kopieren', match: :first
    select '10:00 - 11:00', from: 'Zeit'
    click_on 'Speichern'

    click_on 'Veröffentlichen'
    expect(page).to have_content('Stundenplan veröffentlicht')

    click_on 'Auszubildende'
    click_on 'ohne Klasse'
    click_row_with student.last_name
    click_on 'Bearbeiten'
    select 'Klasse 5a', from: 'person[as_student_attributes][course_id]'
    click_on 'Speichern'

    sign_out

    sign_in student.login.email, '12341234'

    expect(page).to have_content('Erfolgreich angemeldet.')
    expect(page).to have_content('Stundenplan')
    # click_on 'Stundenplan'
  end

end
