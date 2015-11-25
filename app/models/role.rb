class Role < ActiveRecord::Base
  belongs_to :person, validate: true, inverse_of: :roles
  belongs_to :organisation

  delegate :first_name, :last_name, :name, to: :person, allow_nil: true

  def name
    # person.name if person
    self.class.model_name.human
  end

  rails_admin do
    list do
      field :person
      field(:type) { pretty_value { bindings[:object].class.model_name.human } }
      field :organisation
    end

    show do
      field :person
    end

  end
end
