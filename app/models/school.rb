class School

  # has_many :students, class_name: 'Role::Student', inverse_of: :school, foreign_key: :organisation_id
  # has_many :teachers, class_name: 'Role::Teacher', inverse_of: :school, foreign_key: :organisation_id
  # has_many :education_subjects, inverse_of: :school
  class << self

    def managers(as_role: false)
      as_role ? Manager.all : Person.managers
    end

    def add_manager!(person)
      person.create_as_manager!
    end

    def add_teacher!(person)
      person.create_as_teacher!
    end

    def add_student!(person)
      person = Person.create!(person) if person.is_a?(Hash)
      student = case person
      when Person  then person.create_as_student!
      when Student then person
      else fail 'param must be Hash, Person or Role::Student'
      end
      student
    end
  end

end
