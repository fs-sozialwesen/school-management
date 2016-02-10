# class Timetable::Lesson < ActiveRecord::Base
#
#   belongs_to :course,  inverse_of: :lessons, required: true
#   belongs_to :teacher, inverse_of: :lessons, required: true, class_name: 'Person'
#   belongs_to :subject, inverse_of: :lessons, required: true
#   belongs_to :room,    inverse_of: :lessons, required: true
#   belongs_to :time_block
#
#   validates :date, presence: true
#
# end
