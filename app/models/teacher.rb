class Teacher < ActiveRecord::Base

  validates :first_name, :last_name, :email, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  rails_admin do
    navigation_label 'Stammdaten'

    list do
      field :name
      include_all_fields
      exclude_fields :first_name, :last_name
      field(:email, :email)
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end

    show do
      field :name
      include_all_fields
      exclude_fields :first_name, :last_name
      field(:email, :email)
      field(:address, :address)
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end
  end
end
