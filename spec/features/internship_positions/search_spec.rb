# Feature: Sign in
#   As a student (or manager or admin)
#   I want to be able to search and filter open internship positions
#   So I can find the best position for me
feature 'Internship positions search', :devise do

  # Scenario: Student sees the whole list of internship positions
  #   Given I'm logged in as a student
  #   When I go to the internship positions list
  #   Then I see a list of all internship positions
  scenario 'student sees all internship positions' do
    person  = FactoryGirl.create(:person)
    student = School.add_student! person

    ip1 = FactoryGirl.create(:internship_position)
    ip2 = FactoryGirl.create(:internship_position)

    signin(person.login.email, '12341234')
    visit internship_positions_path
    expect(page).to have_content ip1.name
    expect(page).to have_content ip2.name
  end
end
