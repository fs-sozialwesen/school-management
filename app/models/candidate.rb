class Candidate < ActiveRecord::Base
  enum status: {
    rejected:       -1,
    canceled:       -2,

    created:        0,
    approved:       1,
    accepted:       2,
  }

  belongs_to :person, validate: true, inverse_of: :as_candidate

  serialize :school_graduate, Graduate
  serialize :profession_graduate, Graduate
  serialize :interview, Interview

  accepts_nested_attributes_for :person

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

  rails_admin do
    list do
      field :person
      field :created_at
      field :year
      # field(:status) { pretty_value { bindings[:object].aasm.human_state } }
      # field :education_subject
      field(:school_graduate)     { pretty_value { value.graduate } }
      field(:profession_graduate) { pretty_value { value.graduate } }
    end

    edit do
      # field(:education_subject, :enum) { enum EducationSubject.pluck(:name) }
      field(:year, :enum) { enum (Date.today.year..(Date.today.year + 2)).to_a }
      field :attachments
    end
  end
end
