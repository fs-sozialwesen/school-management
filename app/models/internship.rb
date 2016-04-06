class Internship < ActiveRecord::Base
  belongs_to :student, required: true, inverse_of: :internships
  belongs_to :institution, required: true, inverse_of: :internships
  belongs_to :internship_position #, required: true
  has_one :organisation, through: :institution
  belongs_to :mentor

  validates :start_date, :end_date, presence: true
end
