# Feature: Sign in
#   As a student (or manager)
#   I want to be able to search and filter open internship positions
#   So I can find the best position for me
feature 'Internship positions search', :devise do

  # Scenario: Student sees the whole list of internship positions
  #   Given I'm logged in as a student
  #   When I go to the internship positions list
  #   Then I see a list of all internship positions
  #   When I click on one result
  #   Then I see the details of this internship position
  scenario 'student sees all internship positions' do
    ip1 = FactoryGirl.create(:internship_position, name: 'PP1', description: 'Very good here!')
    ip2 = FactoryGirl.create(:internship_position, name: 'PP2')

    sign_in_as_student

    click_on 'Praktikumsplätze'
    expect(page).to have_content 'PP1'
    expect(page).to have_content 'PP2'

    click_on 'PP1'
    expect(page).to have_content 'PP1'
    expect(page).to have_content ip1.description
    expect(page).to have_content ip1.address.street

    # expectations = [:name, :description].map { | attr | ip1.send attr }
    # expectations += %i(street zip city).map { | attr | ip1.address.send attr }
    # expectations += %i(person email phone fax).map { | attr | ip1.contact.send attr }
    # expectations.each { |expectation| expect(page).to have_content expectation }
    # save_and_open_page
  end
end
