# Feature: Sign in
#   As a student
#   I want to be able to search and filter open internship positions
#   So I can find the best position for me
feature 'Internship positions search', :devise do

  # Scenario: Student sees the whole list of internship positions fitting their education subject
  #   Given I'm logged in as a student with a education subject x
  #   When I go to the internship positions list
  #   Then I see a list of all i p having the same education subject I have
  scenario 'student sees all internship positions of his education subject' do
    education_subject       = EducationSubject.last
    other_education_subject = EducationSubject.first
    student = FactoryGirl.create(:person, :student).as_student
    allow(student).to receive(:education_subject).and_return(education_subject)

    ip1 = FactoryGirl.create(:internship_position, name: 'Institution1', education_subject: education_subject)
    ip2 = FactoryGirl.create(:internship_position, name: 'Institution2', education_subject: other_education_subject)

    login = student.person.login
    # login.confirm
    # login.save
    signin(login.email, '12341234')
    # binding.pry

    save_and_open_page

    visit internship_positions_path
    # save_and_open_page
    expect(page).to have_content ip1.name
  end

  # # Scenario: User can sign in with valid credentials
  # #   Given I exist as a user
  # #   And I am not signed in
  # #   When I sign in with valid credentials
  # #   Then I see a success message
  # scenario 'user can sign in with valid credentials' do
  #   login = FactoryGirl.create(:login)
  #   signin(login.email, login.password)
  #   expect(page).to have_content I18n.t 'devise.sessions.signed_in'
  # end
  #
  # # Scenario: User cannot sign in with wrong email
  # #   Given I exist as a user
  # #   And I am not signed in
  # #   When I sign in with a wrong email
  # #   Then I see an invalid email message
  # scenario 'user cannot sign in with wrong email' do
  #   login = FactoryGirl.create(:login)
  #   signin('invalid@email.com', login.password)
  #   expect(page).to have_content I18n.t 'devise.failure.not_found_in_database', authentication_keys: 'email'
  # end
  #
  # # Scenario: User cannot sign in with wrong password
  # #   Given I exist as a user
  # #   And I am not signed in
  # #   When I sign in with a wrong password
  # #   Then I see an invalid password message
  # scenario 'user cannot sign in with wrong password' do
  #   login = FactoryGirl.create(:login)
  #   signin(login.email, 'invalidpass')
  #   expect(page).to have_content I18n.t 'devise.failure.invalid', authentication_keys: 'email'
  # end

end
