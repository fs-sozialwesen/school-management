class Institution < ActiveRecord::Base
  belongs_to :organisation, inverse_of: :institutions, required: true
  # belongs_to :education_subject, required: true

  acts_as_addressable
  acts_as_contactable
  acts_as_housable
  acts_as_applyable

  scope :applying_by, -> (via) { where('applying @> ?', Applying.by(via)) }
  scope :housing, -> (housing) { where('housing @> ?', Housing.provided(housing)) }
  scope :by_city, -> (city) { where('institutions.address @> ?', { city: city }.to_json) }
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

  has_paper_trail

  validates :name, presence: true

end
