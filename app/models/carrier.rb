class Carrier < ActiveRecord::Base

  has_many :institutions, inverse_of: :carrier
  # has_many :mentors, inverse_of: :carrier

  composed_of :address, mapping: [%w(street street), %w(city city), %w(zip zip)]

  has_paper_trail

  def institutions_count
    institutions.count
  end

  rails_admin do
    navigation_label I18n.t(:internship)
    weight -1

    list do
      field :name, :self_link
      field :institutions_count
    end

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
      end
      group :address do
        label 'Adresse'
        field :street
        field :zip
        field :city
      end

      group :institutions do
        field :institutions
      end
    end

  end
end
