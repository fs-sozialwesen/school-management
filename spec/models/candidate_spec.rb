require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe '#generate_student' do
    it 'creates a new association student' do

    end
  end

  describe '#documents_complete?' do
    it 'returns true if police cert, school, profession and internships complete' do
      expect(subject.documents_complete?).to eql false
      subject.police_certificate = true
      expect(subject.school_graduate).to be_complete
      expect(subject.profession_graduate).to be_complete
      expect(subject).to be_internships_complete
      expect(subject.documents_complete?).to eql true
    end
  end

  describe '#internships_complete?' do
    it 'returns true if no internships or proved' do
      expect(subject.internships_complete?).to eql true
      subject.internships = 'Some internships'
      expect(subject.internships_complete?).to eql false
      subject.internships_proved = true
      expect(subject.internships_complete?).to eql true
    end
  end

  describe '#contracts_complete?' do
    it 'returns true if education and internship contract received' do
      expect(subject.contracts_complete?).to eql false
      subject.education_contract_received = Date.current
      expect(subject.contracts_complete?).to eql false
      subject.internship_contract_received = Date.current
      expect(subject.contracts_complete?).to eql true
    end
  end
end
