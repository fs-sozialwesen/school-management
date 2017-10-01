# class Course
class Course < ApplicationRecord
  belongs_to :teacher, required: true, inverse_of: :courses
  has_many :course_memberships
  has_many :active_course_memberships, -> { where active: true }, class_name: 'CourseMembership'
  has_many :students, inverse_of: :course
  has_many :time_tables, inverse_of: :course
  has_many :lessons, through: :time_tables

  has_paper_trail
  acts_as_taggable_on :education_subjects

  include PgSearch
  multisearchable against: [:name]

  scope :active,   -> { where('end_date > ?',  Date.current) }
  scope :inactive, -> { where('end_date <= ?', Date.current) }

  validates :name, :start_date, :end_date, presence: true

  def active?
    end_date > Date.current
  end

  # def remove_all_logins
  #   students.each { | student | student.login.destroy if student.login }
  # end

end
