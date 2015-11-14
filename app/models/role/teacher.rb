class Role < ActiveRecord::Base
  class Teacher < Role

    has_many :courses
    # has_many :lessons, inverse_of: :teacher

    rails_admin do
      list do
        field :organisation
        field :person
        field :courses do
          formatted_value do
            value.map{ |course| course.education_subject.school.name }.uniq.join(', ')
          end
          pretty_value do
            value.map{ |course| course.education_subject.school.name }.uniq.join(', ')
          end
        end
      end
    end

  end
end
