class Internship < ActiveRecord::Base
  belongs_to :student,             inverse_of: :internships
  belongs_to :internship_position, inverse_of: :internships
  belongs_to :mentor,              inverse_of: :internships

  has_paper_trail

end
