class Timetable::Room < ActiveRecord::Base
  validates :name, presence: true
  has_paper_trail
end
