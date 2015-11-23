class Role < ActiveRecord::Base
  class Teacher < Role

    has_many :courses
    belongs_to :school, class_name: 'Organisation::School', foreign_key: :organisation_id, inverse_of: :teachers

    # has_many :lessons, inverse_of: :teacher

    def display_name
      person.name
    end

    rails_admin do
      configure :school do
        formatted_value do
          value.name if value
        end
      end
      list do
        field :first_name, :self_link
        field :last_name, :self_link
        field :school
        field :courses
      end
      show do
        field :person
        field :school
        field :courses
      end
      edit do
        field :person
        field :school
        field :courses
      end
    end

  end
end
