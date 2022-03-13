class Mentor < ActiveRecord::Base
  belongs_to :person
  belongs_to :organisation, required: true, inverse_of: :mentors
  has_many :internships

  scope :with_person, -> { joins(:person).order('people.last_name') }
  scope :active, -> { with_person.where(people: {archived: false}) }

  delegate :first_name, :last_name, :name, :archived?, to: :person, allow_nil: true

end
