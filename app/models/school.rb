class School < ActiveRecord::Base

  acts_as_addressable
  acts_as_contactable

  validates :name, presence: true

end
