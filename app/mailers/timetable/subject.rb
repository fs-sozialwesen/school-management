class Timetable::Subject < ActiveRecord::Base

  has_many :lessons, inverse_of: :subject

  has_paper_trail

end
