class Student < ActiveRecord::Base

  validates :first_name, :last_name, :email, :address, :phone, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  rails_admin do
    # navigation_label 'Stammdaten'

    list do
      include_fields :first_name, :last_name, :phone
      field(:email, :email)
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end

    show do
      field :name
      exclude_fields :first_name, :last_name
      field(:email, :email)
      field(:address, :address)
      include_all_fields
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end
  end
end
