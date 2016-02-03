feature 'Manage teachers', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete teachers
#   So I can keep the teacher database up to date

  scenario 'add new teacher' do
    # Given I'm logged in as a manager
    sign_in_as_manager

    # When I go to the teachers list
    visit teachers_people_path

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
    expect(page).to have_content 'Persondaten gespeichert'
    expect(page).to have_content 'John Meyer'
  end

  scenario 'watch teachers profile'
  scenario 'list'
  scenario 'edit'

  scenario 'full roundtrip', js: true do
    sign_in_as_manager
    visit teachers_people_path
    expect(page).to have_content 'Neu'
    click_on 'Neu'

    {
      first_name: 'Frank',
      last_name: 'Meyer'
    }.each do | field, value |
      fill_in Person.human_attribute_name(field), with: value
    end

    click_on 'Speichern'
    expect(page).to have_content 'Persondaten gespeichert'
    expect(page).to have_content 'Frank Meyer'

    expect(page).to have_content 'Liste'
    click_on 'Liste'
    expect(page).to have_content 'Frank'
    expect(page).to have_content 'Meyer'

    # click_on 'Frank'
    page.find(:xpath,"//*[text()='Frank']").click
    expect(page).to have_content 'Frank Meyer'

    expect(page).to have_content 'Bearbeiten'
    click_on 'Bearbeiten'
  end

end
