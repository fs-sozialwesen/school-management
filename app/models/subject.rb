class Subject < ActiveRecord::Base
  # has_many :lessons, inverse_of: :subject

  validates :name, presence: true, uniqueness: true

  has_paper_trail
end
