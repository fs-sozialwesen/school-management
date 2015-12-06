class Role < ActiveRecord::Base
  class Student < Role

    has_many :course_memberships, dependent: :delete_all
    has_many :courses, through: :course_memberships
    has_one :course_membership, -> { where active: true }
    has_one :course, through: :course_membership
    has_one :education_subject, through: :course
    has_one :school, through: :education_subject

    def display_name
      person.name
    end

    rails_admin do
      parent Course

      Course.course_scopes.each do |course_sym, course_name|
        I18n.backend.store_translations :de, {admin: {scopes: {'role~student' => {course_sym => course_name}}}}
        Role::Student.scope course_sym, -> do
          Role::Student.includes(:course_memberships, :courses).
            where(course_memberships: {active: true}).
            where(courses: {name: course_name})
        end
      end

      configure :person do
        read_only true
      end

      list do
        scopes [nil] + Course.course_scopes.keys.sort
        field :first_name, :self_link
        field :last_name, :self_link
        fields :course, :education_subject
      end
      show do
        fields :person, :course, :school, :education_subject
      end

      edit do
        # exclude_fields :course_memberships, :courses, :course_membership, :internships, :type, :organisation
        field :organisation
      end

      export do
        field :id
        field :created_at
        field :person
        field :school
      end
    end

  end
end
