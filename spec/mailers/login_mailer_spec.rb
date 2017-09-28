require "rails_helper"

RSpec.describe LoginMailer, type: :mailer do
  describe 'create_password_email' do
    let(:person)   { create :person }
    let(:password) { '12341234' }
    let(:mail)     { LoginMailer.create_password_email(person.login, password) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Passwort zu deinem Account')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([person.login.email])
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
