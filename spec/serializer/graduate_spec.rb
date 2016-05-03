require 'rails_helper'

RSpec.describe Graduate, type: :model do
  describe '#complete?' do
    it 'returns true if graduate blank or proved' do
      expect(subject).to be_complete
      subject.graduate = 'Grade'
      expect(subject).to_not be_complete
      subject.proved = true
      expect(subject).to be_complete
    end
  end
end
