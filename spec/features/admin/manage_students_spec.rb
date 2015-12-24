# Feature: Manage students
#   As a admin
#   I want to be able to list, edit and delete all students
#   So I can keep an overview
feature 'manage students', :devise do

  # Scenario:
  #   Given I'm logged in as an manager
  #   When I go to the admin students page
  #   Then I see a list of all students grouped by course
  scenario 'list all people' do
    manager = Person.managers.first
    expect(manager).to be_present

    login = manager.login


    signin(login.email, (manager.first_name + manager.last_name).downcase)


    visit rails_admin.dashboard_path
    visit rails_admin.index_path(model_name: 'role~student', scope: '_all')
    #
    # visit rails_admin.index_path(model_name: 'person', scope: 'teachers')
    # only_managers = Person.managers.all - Person.teachers.all
    # expect(only_managers.count).to be > 0
    # only_managers.each { |manager| expect(page).not_to have_content(manager.email) }
    #
    # visit rails_admin.index_path(model_name: 'person', scope: 'managers')
    # only_teachers = Person.teachers.all - Person.managers.all
    # expect(only_teachers.count).to be > 0
    # only_teachers.each { |teacher| expect(page).not_to have_content(teacher.email) }

  end
end
