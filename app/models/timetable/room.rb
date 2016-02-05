class Timetable::Room < ActiveRecord::Base
  validates :name, presence: true
end
