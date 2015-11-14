include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    login = FactoryGirl.create(:login)
    login_as(login, :scope => :user)
    visit user_path(login)
    expect(page).to have_content 'Login'
    expect(page).to have_content login.email
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see an 'access denied' message
  scenario "user cannot see another user's profile" do
    me = FactoryGirl.create(:login)
    other = FactoryGirl.create(:lgin, email: 'other@example.com')
    login_as(me, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit login_path(other)
    expect(page).to have_content 'Access denied.'
  end

end
