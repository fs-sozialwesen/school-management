class Room < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_paper_trail
end
