class Timetable::Room < ActiveRecord::Base

  # has_many :lessons, inverse_of: :room

  has_paper_trail

end
