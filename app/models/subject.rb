class Subject < ApplicationRecord
  has_many :lessons, inverse_of: :subject, dependent: :restrict_with_error 

  validates :name, presence: true, uniqueness: true

  has_paper_trail
end
