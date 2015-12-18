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

  # Scenario: User changes email address
  #   Given I am signed in
  #   When I change my email address
  #   Then I see an account updated message
  scenario 'user changes email address' do
    skip
    login = FactoryGirl.create(:person).login
    login_as(login, scope: :login)
    visit edit_login_registration_path(login)
    fill_in Login.human_attribute_name(:email), :with => 'newemail@example.com'
    fill_in 'Current password', with: login.password
    click_button 'Update'
    txts = [I18n.t( 'devise.registrations.updated'), I18n.t( 'devise.registrations.update_needs_confirmation')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
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
    expect(page).to have_field(Login.human_attribute_name(:email), with: me.email)
  end

end
