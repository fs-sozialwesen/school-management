# Feature: Manage people
#   As a admin
#   I want to be able to list, edit and delete instances of people
#   So I can keep my relations up to date.
feature 'manage people', :devise do

  # Scenario:
  #   Given I'm logged in as an manager
  #   When I go to the admin people page
  #   Then I see a list of all people registered in the database
  scenario 'list all people' do
    manager = Person.managers.first
    expect(manager).to be_present

    login = manager.login
    signin(login.email, (manager.first_name + manager.last_name).downcase)
    visit rails_admin.dashboard_path
    visit rails_admin.index_path(model_name: 'person', scope: '_all')
    Person.all.each do |person|
      expect(page).to have_content person.first_name
      expect(page).to have_content person.last_name
      expect(page).to have_content person.address.city
      expect(page).to have_content person.contact.email
    end

    visit rails_admin.index_path(model_name: 'person', scope: 'teachers')
    only_managers = Person.managers.all - Person.teachers.all
    expect(only_managers.count).to be > 0
    only_managers.each { |manager| expect(page).not_to have_content(manager.email) }

    visit rails_admin.index_path(model_name: 'person', scope: 'managers')
    only_teachers = Person.teachers.all - Person.managers.all
    expect(only_teachers.count).to be > 0
    only_teachers.each { |teacher| expect(page).not_to have_content(teacher.email) }

  end
end
