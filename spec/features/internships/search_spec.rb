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

  scenario 'student apply different filters to the list' do
    ip1 = FactoryGirl.create(:internship_position, name: 'PP1', description: 'Very good here!')
    ip2 = FactoryGirl.create(:internship_position, name: 'PP2')

    ip1.housing.provided = true
    ip1.housing.costs = 'cheap'
    ip1.applying.by_phone = false
    ip1.applying.by_mail = true
    ip1.applying.by_email = false
    ip1.save

    ip2.housing.provided = false
    ip2.applying.by_phone = false
    ip2.applying.by_mail = false
    ip2.applying.by_email = true
    ip2.save

    sign_in_as_student

    click_on 'Praktikumsplätze'
    expect(page).to have_content 'PP1'
    expect(page).to have_content 'PP2'

    choose 'mit'
    click_on 'Suchen'
    expect(page).to     have_content 'PP1'
    expect(page).not_to have_content 'PP2'

    click_on 'Alle'
    choose 'Post'
    click_on 'Suchen'
    expect(page).to     have_content 'PP1'
    expect(page).not_to have_content 'PP2'

    click_on 'Alle'
    choose 'E-Mail'
    click_on 'Suchen'
    expect(page).not_to have_content 'PP1'
    expect(page).to     have_content 'PP2'

    click_on 'Alle'
    choose 'Telefon'
    click_on 'Suchen'
    expect(page).not_to have_content 'PP1'
    expect(page).not_to have_content 'PP2'

  end
end
