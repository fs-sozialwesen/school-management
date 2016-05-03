require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe '#teacher_name' do
    it 'gives the shortened name' do
      teacher = Teacher.new person_attributes: { first_name: 'John', last_name: 'Terry' }
      subject.teacher = teacher

      expect(subject.teacher_name).to eql 'J. Terry'
    end
  end
end
