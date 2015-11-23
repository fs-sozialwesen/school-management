class Organisation < ActiveRecord::Base

  acts_as_addressable
  acts_as_contactable

  belongs_to :carrier, class_name: 'Organisation'

  has_many :contracts_as_first_party,  as: :first_party,  class_name: 'Contract'
  has_many :contracts_as_second_party, as: :second_party, class_name: 'Contract'

  has_many :roles

  has_many :internship_positions, inverse_of: :organisation


  def contracts
    contracts_as_first_party + contracts_as_second_party
  end

  rails_admin do

    Address. attribute_set.each { |attr| configure(attr.name) { group :address } }
    Contact. attribute_set.each { |attr| configure(attr.name) { group :contact } }

    list do
      field(:type) { pretty_value { bindings[:object].class.model_name.human } }
      field :name, :self_link
      fields :city, :carrier
    end
    show do
      fields :name, :carrier, :comments
      fields :street, :zip, :city
      fields :person, :email, :mobile, :phone, :fax, :homepage
    end
    edit do
      fields :name, :carrier, :comments
      fields :street, :zip, :city
      fields :person, :email, :mobile, :phone, :fax, :homepage
    end
  end

end
