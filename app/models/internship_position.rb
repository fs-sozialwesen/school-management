class InternshipOffer < ActiveRecord::Base

  belongs_to :organisation, inverse_of: :internship_offers
  has_many :internship_positions, inverse_of: :internship_offer, dependent: :destroy

  serialize :address,  Address
  serialize :contact,  Contact
  serialize :housing,  Housing
  serialize :applying, Applying
  serialize :positions, Positions

  # delegate :by_phone,  :by_email,  :by_mail,  :documents,  to: :application_options, prefix: :application
  # delegate :by_phone=, :by_email=, :by_mail=, :documents=, to: :application_options, prefix: :application

  scope :applying_by, -> (via = nil)     { via.present? ? where('applying @> ?', Applying.by(via)) : all }
  scope :housing,     -> (housing = nil) { (housing.in? [true, false]) ? where('housing @> ?', Housing.provided(housing)) : all }
  scope :by_city,     -> (city) do
    main_city  = { city: city }.to_json
    other_city = [ { address: { city: city } } ].to_json
    where('((address @> ?) OR (positions @> ?))', main_city, other_city)
  end
  # scope :by_pos_city, -> (city = nil)    { city.blank? ? all : where('positions @> ?', [{address:{city: city}}].to_json) } # positions @> '[{"address":{"city": "Magdeburg"}}]'

  # InternshipOffer.where('positions ? :education_subject_id', education_subject_id: '2').count
  # InternshipOffer.where('positions ?& array[:keys]', keys: ['2']).count

  # InternshipOffer.where("application_options ->>'documents' ILIKE '%leben%'" ).count

  accepts_nested_attributes_for :internship_positions

  def positions_sum
    internship_positions.sum :number_of_positions
  end

  def education_subjects
    internship_positions.map(&:education_subject_count).join(', ')
  end

  rails_admin do
    # parent Organisation

    # configure :application_by_phone, :boolean
    # configure :application_by_email, :boolean
    # configure :application_by_mail,  :boolean
    # configure(:application_documents) { formatted_value { bindings[:object].application_options.documents } }
    # configure :application_options do
    #   formatted_value { bindings[:object].application_options.by_options.join(', ').html_safe }
    # end

    list do
      configure(:city) { pretty_value { bindings[:object].address.city } }
      sort_by :organisation
      # field :id
      field :name, :self_link
      field :organisation
      # field :application_options
      # field :application_documents
      field :city
      field :description
      # field :accommodation
      field :education_subjects
      field :positions_sum
    end

    show do
      field :organisation
      field :name
      field :city
      field :description
      field :education_subjects
      field :positions_sum

      # field :application_options
      # field :application_documents
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
      group :organisation do
        field :organisation do
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
      # group :application do
      #   field :application_by_phone
      #   field :application_by_email
      #   field :application_by_mail
      #   field :application_documents
      # end
    end
  end

end
