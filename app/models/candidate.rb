class Candidate < ActiveRecord::Base
  enum status: {
    rejected: -1,
    canceled: -2,

    created:  0,
    accepted: 1,
  }

  belongs_to :person, validate: true, inverse_of: :as_candidate

  serialize :school_graduate, Graduate
  serialize :profession_graduate, Graduate
  serialize :interview, Interview

  accepts_nested_attributes_for :person

  validates :date, presence: true

  has_paper_trail

  def display_name
    person.name
  end

  def progress
    self[:status]
  end

  def documents_complete?
    police_certificate and school_graduate.complete? and profession_graduate.complete? and internships_complete?
  end

  def internships_complete?
    return true if internships.blank?
    internships_proved
  end

  def contracts_complete?
    %i(education_contract_sent education_contract_received
       internship_contract_sent internship_contract_received ).all? do |contract|
      send(contract).present?
    end
  end

end
