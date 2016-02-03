feature 'Manage managers', :devise do
#   As a manager
#   I want to be able to add, find, edit and delete managers
#   So I can keep the managers database up to date

  scenario 'full roundtrip' do
    sign_in_as_manager
    visit managers_people_path
    expect(page).to have_content 'Neu'
    click_on 'Neu'

    fill_in 'Vorname', with: 'Frank'
    fill_in 'Nachname', with: 'Meyer'

    click_on 'Speichern'
    expect(page).to have_content 'Personendaten gespeichert'
    expect(page).to have_content 'Frank Meyer'

    expect(page).to have_content 'Liste'
    click_on 'Liste'
    expect(page).to have_content 'Frank'
    expect(page).to have_content 'Meyer'

     # click_on_any 'Frank'
    # page.find(:xpath, "//*[normalize-space()='#{text}']")
    visit page.find('tr[data-url]:first-child')['data-url']

    expect(page).to have_content 'Manager'

    expect(page).to have_content 'Bearbeiten'
    click_on 'Bearbeiten'

    select('Herr', from: 'Anrede')
    {
      'Vorname'        => '',
      'Geburtsdatum'   => '1.1.1996',
      'PLZ'            => '12345',
      'E-Mail-Adresse' => 'a@b.c',
      'Telefon'        => '09876',
      'Mobiltelefon'   => '01234567',
    }.each do | field, value |
      fill_in field, with: value
    end

    click_on 'Speichern'
    expect(page).to have_content 'Personendaten konnten nicht gespeichert werden'

    fill_in 'Vorname', with: 'Rodriges'
    fill_in 'Nachname', with: 'Gonzales'

    click_on 'Speichern'
    expect(page).to have_content 'Personendaten gespeichert'
    expect(page).to have_content 'Rodriges Gonzales'
    click_on 'Liste'

    expect(page).to have_selector('tbody tr[data-url]', count: 4)
    visit find_table_row('Rodriges')['data-url']
    click_on 'Löschen'
    expect(page).to have_content 'gelöscht'
    expect(page).to have_current_path(managers_people_path)
    expect(page).to have_selector('tbody tr[data-url]', count: 3)
  end

end
