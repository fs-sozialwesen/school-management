require 'rails_helper'

describe CoursePolicy do

  let(:user)    { Person.new }
  let(:manager) { Person.new.tap { | p | p.build_as_manager } }
  let(:teacher) { Person.new.tap { | p | p.build_as_teacher } }
  let(:student) { Student.new}
  let(:course)  { Course.new }

  subject { described_class }

  permissions :generate_logins? do

    it 'grants access for managers' do
      expect(subject).to permit(manager, course)
    end

    it 'denies access for teachers' do
      expect(subject).not_to permit(teacher, course)
    end

    it 'denies access for students' do
      expect(subject).not_to permit(student, course)
    end
  end

end
