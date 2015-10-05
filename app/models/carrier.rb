class Carrier < ActiveRecord::Base

  has_many :institutions, inverse_of: :carrier
  # has_many :mentors, inverse_of: :carrier

  rails_admin do
    navigation_label 'Praktikum'

    edit do
      exclude_fields :institutions
    end

    show do
      group :default do
        field :name
        field :email
        field :comments
      end
      group :contact do
        label 'Kontakt'
        field :contact_person
        field :phone
        field :fax
        field :street
        field :zip
        field :city
      end
    end

  end
end
