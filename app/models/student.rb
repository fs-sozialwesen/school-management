class Student < ActiveRecord::Base
  belongs_to :person, validate: true, inverse_of: :as_student
  has_one :login, through: :person
  belongs_to :course, inverse_of: :students
  has_many :internships, inverse_of: :student

  has_many :course_memberships, dependent: :delete_all
  has_many :courses, through: :course_memberships
  has_one :course_membership, -> { where active: true }
  # has_one :course, through: :course_membership
  # has_one :education_subject, through: :course
  # has_one :school, through: :education_subject
  has_one :candidate, inverse_of: :student

  accepts_nested_attributes_for :person
  delegate :first_name, :last_name, :name, to: :person, allow_nil: true

  has_paper_trail

end
