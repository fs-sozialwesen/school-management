class Mentor < ActiveRecord::Base
  belongs_to :person
  belongs_to :organisation, required: true, inverse_of: :mentors
  has_many :internships

  delegate :first_name, :last_name, :name, to: :person, allow_nil: true

end
