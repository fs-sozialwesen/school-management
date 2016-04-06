class Organisation < ActiveRecord::Base

  acts_as_addressable
  acts_as_contactable

  belongs_to :carrier, class_name: 'Organisation'

  # has_many :contracts_as_first_party,  as: :first_party,  class_name: 'Contract'
  # has_many :contracts_as_second_party, as: :second_party, class_name: 'Contract'

  # has_many :roles

  has_many :internship_positions, inverse_of: :organisation
  has_many :institutions, inverse_of: :organisation
  has_many :mentors, inverse_of: :organisation

  has_paper_trail

  validates :name, presence: true

  # def contracts
  #   contracts_as_first_party + contracts_as_second_party
  # end

end
