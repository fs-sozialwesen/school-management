class Candidate < ActiveRecord::Base
  enum status: {
    rejected: -1,
    canceled: -2,

    created:  0,
    accepted: 1,
  }

  belongs_to :student, inverse_of: :candidate

  # acts_as_addressable
  # acts_as_contactable

  serialize :address, ::Address
  serialize :contact, ::Contact

  serialize :school_graduate, Graduate
  serialize :profession_graduate, Graduate
  serialize :interview, Interview

  validates :first_name, :last_name, :date, presence: true

  has_paper_trail

  def name
    "#{first_name} #{last_name}"
  end

  def accept!
    accepted!
    generate_student unless student.present?
  end

  def generate_student
    create_student! active: true,
      person_attributes: {
        first_name: first_name,
        last_name: last_name,
        gender: gender,
        date_of_birth: date_of_birth,
        place_of_birth: place_of_birth,
        address: address,
        contact: contact
      }
  end

  def documents_complete?
    police_certificate && school_graduate.complete? &&
      profession_graduate.complete? && internships_complete?
  end

  def internships_complete?
    internships.blank? || internships_proved
  end

  def contracts_complete?
    education_contract_received.present? && internship_contract_received.present?
  end

end
