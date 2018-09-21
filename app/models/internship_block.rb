class InternshipBlock < ActiveRecord::Base

  has_many :internships, inverse_of: :internship_block
  has_many :students, -> { uniq }, through: :internships, source: :student
  has_many :courses, -> { uniq }, through: :students, source: :course

  validates :name, presence: true, uniqueness: true
  validates :course_year, presence: true

end
