class Role::Candidate < Role

  serialize :options, CandidateOptions
  delegate *CandidateOptions.attribute_set.map(&:name), to: :options
  delegate :acceptable?, to: :options
  # delegate :education_subject, :year, to: :options
  # delegate :education_subject=, :year=, :add_attachment, to: :options
  # delegate :school_graduate,  :profession_graduate,  :education_graduate,  to: :options
  # delegate :school_graduate=, :profession_graduate=, :education_graduate=, to: :options

  accepts_nested_attributes_for :person

  def display_name
    person.name
  end


  rails_admin do
    edit do
      field(:education_subject, :enum) { enum EducationSubject.pluck(:name) }
      field(:year, :enum) { enum (Date.today.year..(Date.today.year + 2)).to_a }
      field :attachments
    end
  end
end
