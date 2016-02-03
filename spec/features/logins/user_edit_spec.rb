include Warden::Test::Helpers
Warden.test_mode!

# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'Login edit', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User cannot edit another user's profile
  #   Given I am signed in
  #   When I try to edit another user's profile
  #   Then I see my own 'edit profile' page
  scenario "user cannot edit another user's profile", :me do
    me = FactoryGirl.create(:person).login
    # other = FactoryGirl.create(:person, email: 'other@example.com')
    other = FactoryGirl.create(:person).login
    login_as(me, scope: :login)
    visit edit_login_registration_path(other)
    # save_and_open_page
    # expect(page).to have_content I18n.t('devise.registrations.edit.title')
    expect(page).to have_field(:login_current_password)
    expect(page).to have_field(:login_password)
    expect(page).to have_field(:login_password_confirmation)
  end

end
