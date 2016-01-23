class Teacher < ActiveRecord::Base
  belongs_to :person, validate: true, inverse_of: :as_teacher
  has_many :courses, inverse_of: :teacher

  delegate :first_name, :last_name, :name, to: :person, allow_nil: true

  accepts_nested_attributes_for :person

  # has_many :lessons, inverse_of: :teacher

  def display_name
    person.name
  end

  rails_admin do
    # configure :school do
    #   formatted_value do
    #     value.name if value
    #   end
    # end
    list do
      field :first_name, :self_link
      field :last_name, :self_link
      # field :school
      field :courses
    end
    show do
      field :person
      # field :school
      field :courses
    end
    edit do
      field :person
      # field :school
      field :courses
    end
  end
end
