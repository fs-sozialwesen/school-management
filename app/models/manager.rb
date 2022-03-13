class Manager < ActiveRecord::Base
  belongs_to :person, validate: true, inverse_of: :as_manager
  has_one :login, through: :person

  scope :with_person, -> { joins(:person).order('people.last_name') }
  scope :active, -> { with_person.where(people: {archived: false}) }

  delegate :first_name, :last_name, :name, to: :person, allow_nil: true

  accepts_nested_attributes_for :person

  has_paper_trail

end
