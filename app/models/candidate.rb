class Candidate < ActiveRecord::Base
  enum status: {
    rejected:       -1,
    canceled:       -2,
    created:        0,
    approved:       1,
    interview:      2,
    accepted:       3,
    contracts_back: 4,
    student:        5,
  }

  belongs_to :person, validate: true, inverse_of: :as_candidate

  serialize :options, CandidateOptions
  delegate *CandidateOptions.attribute_set.map(&:name), to: :options
  # delegate :acceptable?, to: :options

  accepts_nested_attributes_for :person

  def display_name
    person.name
  end

  def progress
    self[:status]
  end

  rails_admin do
    list do
      field :person
      field :created_at
      field :year
      # field(:status) { pretty_value { bindings[:object].aasm.human_state } }
      field :education_subject
      field(:school_graduate)     { pretty_value { value.graduate } }
      field(:profession_graduate) { pretty_value { value.graduate } }
    end

    edit do
      field(:education_subject, :enum) { enum EducationSubject.pluck(:name) }
      field(:year, :enum) { enum (Date.today.year..(Date.today.year + 2)).to_a }
      field :attachments
    end
  end
end
