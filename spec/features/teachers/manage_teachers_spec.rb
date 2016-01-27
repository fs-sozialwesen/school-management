feature 'Manage teachers', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete teachers
#   So I can keep the teacher database up to date

  scenario 'add new teacher' do
    # Given I'm logged in as a manager
    sign_in_as_manager

    # When I go to the teachers list
    visit teachers_path

    # And I click on 'New'
    expect(page).to have_content 'Neu'
    click_on 'Neu'

    # Then I see the form to create a new teacher
    # When I enter first name and last name of the teacher
    fill_in Person.human_attribute_name(:first_name), with: 'John'
    fill_in Person.human_attribute_name(:last_name), with: 'Meyer'

    # And click save
    click_on 'Speichern'

    # Then I see the teacher
    expect(page).to have_content 'Lehrer(in) gespeichert'
    expect(page).to have_content 'John Meyer'
  end

end
