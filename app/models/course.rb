# class Course
class Course < ActiveRecord::Base
  belongs_to :teacher, required: true, inverse_of: :courses
  # belongs_to :education_subject, required: true, inverse_of: :courses

  # has_one :leadership
  # has_one :course_teacher, through: :leadership

  has_many :course_memberships
  has_many :active_course_memberships, -> { where active: true }, class_name: 'CourseMembership'
  has_many :students, inverse_of: :course #, through: :active_course_memberships
  # has_many :lessons, inverse_of: :course
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

  # def add_student!(student)
  #   course_memberships.find_or_create_by! student: student
  #   student.course = self
  # end

  def students_without_login
    students.includes(person: :login).order('people.last_name').where('logins.id' => nil)
  end

  # def remove_all_logins
  #   students.each { | student | student.login.destroy if student.login }
  # end

end
