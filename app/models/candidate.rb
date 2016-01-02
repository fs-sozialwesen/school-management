class Candidate < ActiveRecord::Base
  belongs_to :person, validate: true, inverse_of: :as_candidate

  serialize :options, CandidateOptions
  delegate *CandidateOptions.attribute_set.map(&:name), to: :options
  delegate :acceptable?, to: :options

  accepts_nested_attributes_for :person

  def display_name
    person.name
  end

  def progress
    return -1 if rejected
    return  3 if accepted
    return  2 if invited
    return  1 if approved
    0
  end

  def highest_status
    { -1 => :rejected, 0 => :created, 1 => :approved, 2 => :invited, 3 => :accepted }[progress]
  end

  %i(init approve invite accept reject).each do |action|
    define_method("#{action}!") do
      options.send action
      save
    end
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
