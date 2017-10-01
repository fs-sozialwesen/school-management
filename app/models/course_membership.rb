class CourseMembership < ApplicationRecord
  belongs_to :student, required: true
  belongs_to :course, required: true

  before_create :set_defaults
  after_create :deactivate_older_memberships

  has_paper_trail


  # def name
  #   "#{student.try :name} #{course.try :name}"
  # end
  #
  # def finish!
  #   self.active = false
  #   self.end_date = Date.today
  #   save
  # end
  #
  # private
  #
  # def set_defaults
  #   # self.active = true if active.nil?
  #   # self.start_date = Date.today if start_date.nil?
  #   self.active     = course.end_date > Date.today
  #   self.start_date = course.start_date
  #   self.end_date   = course.end_date unless active?
  # end
  #
  # def deactivate_older_memberships
  #   student.course_memberships.where.not(id: self.id).update_all(active: false) if active?
  # end
end
