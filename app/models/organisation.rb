class Organisation < ActiveRecord::Base

  serialize :address, Address
  serialize :contact, Contact

  belongs_to :carrier, class_name: 'Organisation'

  has_many :contracts_as_first_party,  as: :first_party,  class_name: 'Contract'
  has_many :contracts_as_second_party, as: :second_party, class_name: 'Contract'

  has_many :roles

  has_many :internship_offers, inverse_of: :organisation


  def contracts
    contracts_as_first_party + contracts_as_second_party
  end

  rails_admin do
    list do
      field(:type) { pretty_value { bindings[:object].class.model_name.human } }
      field :name
      # field :city
      field :carrier
    end
  end

end
