class Teacher < ActiveRecord::Base
  belongs_to :person, validate: true, inverse_of: :as_teacher
  has_one :login, through: :person
  has_many :courses, inverse_of: :teacher

  delegate :first_name, :last_name, :name, to: :person, allow_nil: true

  accepts_nested_attributes_for :person

  # has_many :lessons, inverse_of: :teacher

  has_paper_trail

end
