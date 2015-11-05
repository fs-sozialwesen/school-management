class InternshipOffer < ActiveRecord::Base

  belongs_to :carrier, inverse_of: :internship_offers
  has_many :internship_positions, inverse_of: :internship_offer

  # serialize :accommodation_details, Hash
  # serialize :settings, HashSerializer
  serialize :application_options, ApplicationOptions

  delegate :by_phone,  :by_email,  :by_mail,  :documents,  to: :application_options, prefix: :application
  delegate :by_phone=, :by_email=, :by_mail=, :documents=, to: :application_options, prefix: :application

  # default_scope -> { where type: nil }

  accepts_nested_attributes_for :internship_positions

  def positions_sum
    internship_positions.sum :number_of_positions
  end

  def education_subjects
    internship_positions.map(&:education_subject_count).join(', ')
  end

  rails_admin do
    parent Carrier

    configure :application_by_phone, :boolean
    configure :application_by_email, :boolean
    configure :application_by_mail,  :boolean
    configure(:application_documents) { formatted_value { bindings[:object].application_options.documents } }
    configure :application_options do
      formatted_value { bindings[:object].application_options.by_options.join(', ').html_safe }
    end

    list do
      sort_by :carrier
      # field :id
      field :name, :self_link
      field :carrier
      # field :application_options
      # field :application_documents
      field :city
      field :description
      field :accommodation
      field :education_subjects
      field :positions_sum
    end

    show do
      field :carrier
      field :name
      field :city
      field :description
      field :education_subjects
      field :positions_sum

      field :application_options
      field :application_documents
    end

    edit do
      group :default do
        field :name
        field :description
        field :internship_positions
      end
      group :contact do
        label 'Kontakt'
        field :contact_person
        field :email
        field :phone
        field :fax
        field :homepage
      end
      group :carrier do
        field :carrier do
          inline_add false
          inline_edit false
        end
      end
      group :address do
        label 'Adresse'
        field :street
        field :zip
        field :city
      end
      group :application do
        field :application_by_phone
        field :application_by_email
        field :application_by_mail
        field :application_documents
      end
    end
  end

end
