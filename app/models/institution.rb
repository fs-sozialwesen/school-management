class Institution < ActiveRecord::Base

  belongs_to :carrier,            inverse_of: :institutions
  has_many :internship_positions, inverse_of: :institution
  # has_many :mentors,              inverse_of: :institution

  composed_of :address, mapping: [%w(street street), %w(city city), %w(zip zip)]

  has_paper_trail

  rails_admin do
    parent Carrier

    list do
      sort_by :carrier
      field :carrier
      field :name, :self_link
      field :city
    end

    edit do
      group :default do
        field :name
        field :comments
      end
      group :contact do
        label 'Kontakt'
        field :contact_person
        field :email
        field :phone
        field :fax
        field :homepage
      end
      group :address do
        label 'Adresse'
        field :carrier_address
        field :street
        field :zip
        field :city
      end
    end

    show do
      group :default do
        field :name
        field :comments
      end

      group :contact do
        label 'Kontakt'
        field :contact_person
        field :email, :email
        field :phone
        field :fax
        field(:homepage) { pretty_value { bindings[:view].link_to value, value } }
      end
      group :address do
        label 'Adresse'
        field :carrier_address
        field :street
        field :zip
        field :city
      end
      group :internship_positions do
        field :internship_positions
      end

    end

  end
end
