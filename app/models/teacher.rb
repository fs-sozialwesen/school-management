class Teacher < Person

  has_many :courses

  # validates :first_name, :last_name, :email, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  rails_admin do

    # navigation_label 'Stammdaten'

    list do
      field :first_name, :self_link
      field :last_name, :self_link
      field(:email, :email)
      field :city
      field :courses
      # field(:created_at) { date_format :short }
      # field(:updated_at) { date_format :short }
    end

    show do
      field :name
      include_all_fields
      exclude_fields :first_name, :last_name
      field(:email, :email)
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end
  end
end
