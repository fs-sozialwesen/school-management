class Role < ActiveRecord::Base
  class Student < Role

    has_many :course_memberships, dependent: :delete_all
    has_many :courses, through: :course_memberships
    has_one :course_membership, -> { where active: true }
    has_one :course, through: :course_membership
    has_one :education_subject, through: :course
    has_one :school, through: :education_subject

    # Course.course_scopes.each do |course_sym, course_name|
    #   I18n.backend.store_translations :de, {admin: {scopes: {'role~student' => {course_sym => course_name}}}}
    #   scope course_sym, -> do
    #     includes(:course_memberships, :courses).
    #       where(course_memberships: {active: true}).
    #       where(courses: {name: course_name})
    #   end
    # end

    rails_admin do
      parent Course

      list do
        # scopes [nil] + Course.course_scopes.keys.sort
        # field :organisation
        field :school
        field :person
        field :course
        field :education_subject
      end

      edit do
        exclude_fields :course_memberships, :courses, :course_membership, :internships, :type, :organisation, :person
      end
    end

  end
end
