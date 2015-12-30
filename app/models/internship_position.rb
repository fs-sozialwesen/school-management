# class InternshipPosition
class InternshipPosition < ActiveRecord::Base
  belongs_to :organisation, inverse_of: :internship_positions
  # belongs_to :education_subject, required: true

  acts_as_addressable
  acts_as_contactable
  acts_as_housable
  acts_as_applyable

  scope :applying_by, -> (via) { where('applying @> ?', Applying.by(via)) }
  scope :housing, -> (housing) { where('housing @> ?', Housing.provided(housing)) }
  scope :by_city, -> (city) { where('internship_positions.address @> ?', { city: city }.to_json) }
  # scope :by_city,     -> (city) do
  #   main_city  = { city: city }.to_json
  #   other_city = [ { address: { city: city } } ].to_json
  #   where('((address @> ?) OR (positions @> ?))', main_city, other_city)
  # end
  # scope :by_pos_city, -> (city = nil)    { city.blank? ? all : where('positions @> ?',
  # [{address:{city: city}}].to_json) } # positions @> '[{"address":{"city": "Magdeburg"}}]'

  # where('positions ? :education_subject_id', education_subject_id: '2').count
  # where('positions ?& array[:keys]', keys: ['2']).count

  # where("applying ->>'documents' ILIKE '%leben%'" ).count

  rails_admin do
    # parent Organisation
    Address. attribute_set.each { |attr| configure(attr.name) { group :address } }
    Contact. attribute_set.each { |attr| configure(attr.name) { group :contact } }

    configure(:housing_provided, :boolean) { group :housing }
    configure(:housing_costs)    { group :housing }

    configure(:applying_by_mail,   :boolean) { group :applying }
    configure(:applying_by_email,  :boolean) { group :applying }
    configure(:applying_by_phone,  :boolean) { group :applying }
    configure(:applying_documents)           { group :applying }

    configure(:work_area, :enum) { enum { Enum.work_areas } }

    list do
      sort_by :organisation

      field :work_area#, :education_subject
      field :name, :self_link
      fields :organisation, :city, :positions_count
      field :housing_provided
    end
    show do
      fields :name, :organisation
      fields :street, :zip, :city
      fields :person, :email, :mobile, :phone, :fax, :homepage
      fields :housing_provided, :housing_costs
      fields :applying_by_mail, :applying_by_email, :applying_by_phone, :applying_documents
    end
    edit do
      fields :name, :organisation, :description, :work_area
      fields :street, :zip, :city
      fields :person, :email, :mobile, :phone, :fax, :homepage
      fields :housing_provided, :housing_costs
      fields :applying_by_mail, :applying_by_email, :applying_by_phone, :applying_documents
    end
  end
end
