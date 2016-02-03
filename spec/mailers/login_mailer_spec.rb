require "rails_helper"

RSpec.describe LoginMailer, type: :mailer do
  describe 'create_password_email' do
    let(:person) {FactoryGirl.build_stubbed :person }
    let(:login) { FactoryGirl.build_stubbed :login, person: person }
    let(:password) { '12341234' }
    let(:mail) { LoginMailer.create_password_email(login, password) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Passwort zu deinem Account')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([login.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql([ENV['MAILER_ADDRESS']])
    end

    it 'assigns users first name' do
      expect(mail.body.encoded).to match(person.first_name)
    end

    it 'assigns @password' do
      expect(mail.body.encoded).to match(password)
    end

    it 'assigns the login link' do
      expect(mail.body.encoded).to match(new_login_session_url)
    end
  end
end
