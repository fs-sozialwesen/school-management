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
    # education_subject = EducationSubject
    #   .joins(:courses)
    #   .group('education_subjects.id')
    #   .having('count(courses.id) > 0')
    #   .first
    # other_education_subject = EducationSubject.where.not(id: education_subject.id).first
    #
    # expect(education_subject.courses.count).to be > 0
    # course  = education_subject.courses.active.first
    person  = FactoryGirl.create(:person)
    student = School.add_student! person
    # course.add_student! student

    ip1 = FactoryGirl.create(:internship_position)
    ip2 = FactoryGirl.create(:internship_position)

    signin(person.login.email, '12341234')
    visit internship_positions_path
    expect(page).to     have_content ip1.name
    expect(page).not_to have_content ip2.name
  end
end
