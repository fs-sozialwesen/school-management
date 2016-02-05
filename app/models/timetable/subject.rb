class Timetable::Subject < ActiveRecord::Base
  # has_many :lessons, inverse_of: :subject

  validates :name, presence: true

  has_paper_trail
end
