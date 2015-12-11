class Role::Candidate < Role

  serialize :options, CandidateOptions
  delegate *CandidateOptions.attribute_set.map(&:name), to: :options
  delegate :acceptable?, to: :options
  # delegate :education_subject, :year, to: :options
  # delegate :education_subject=, :year=, :add_attachment, to: :options
  # delegate :school_graduate,  :profession_graduate,  :education_graduate,  to: :options
  # delegate :school_graduate=, :profession_graduate=, :education_graduate=, to: :options

  accepts_nested_attributes_for :person

  include AASM

  aasm column: 'status' do
    state :created, initial: true
    state :approved
    state :invited
    state :accepted
    state :rejected

    event(:init)    { transitions to: :created }
    event(:approve) { transitions from: :created,  to: :approved }
    event(:invite)  { transitions from: :approved, to: :invited }
    event(:accept)  { transitions from: :invited,  to: :accepted }
    event(:reject)  { transitions to: :rejected }
  end

  def display_name
    person.name
  end


  rails_admin do
    list do
      field :person
      field :created_at
      field :year
      field(:status) { pretty_value { bindings[:object].aasm.human_state } }
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
