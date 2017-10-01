class Manager < ApplicationRecord
  belongs_to :person, validate: true, inverse_of: :as_manager
  has_one :login, through: :person

  delegate :first_name, :last_name, :name, to: :person, allow_nil: true

  accepts_nested_attributes_for :person

  has_paper_trail

end
