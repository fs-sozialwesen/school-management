class Student < ActiveRecord::Base
  belongs_to :person, validate: true, inverse_of: :as_student
  belongs_to :course, inverse_of: :students

  has_many :course_memberships, dependent: :delete_all
  has_many :courses, through: :course_memberships
  has_one :course_membership, -> { where active: true }
  # has_one :course, through: :course_membership
  # has_one :education_subject, through: :course
  # has_one :school, through: :education_subject

  delegate :first_name, :last_name, :name, to: :person, allow_nil: true

  def display_name
    person.name
  end

  rails_admin do
    parent Course

    Course.course_scopes.each do |course_sym, course_name|
      I18n.backend.store_translations :de, admin:
        { scopes: { 'student' => { course_sym => course_name } } }

      Student.scope course_sym, -> {
        Student.includes(:courses).where(courses: { name: course_name })
      }
    end

    configure(:person) { read_only true }

    list do
      scopes [nil] + Course.course_scopes.keys.sort
      field :first_name, :self_link
      field :last_name, :self_link
      fields :course #, :education_subject
    end
    show do
      fields :person, :course #, :school, :education_subject
    end

    edit do
      # field :organisation
    end

    export do
      field :id
      field :created_at
      field :person
      # field :school
    end
  end
end
