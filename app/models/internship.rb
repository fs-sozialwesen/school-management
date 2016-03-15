class Internship < ActiveRecord::Base
  belongs_to :student, required: true, inverse_of: :internships
  belongs_to :internship_position, required: true

  validates :start_date, :end_date, presence: true
end
