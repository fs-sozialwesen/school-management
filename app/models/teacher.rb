class Teacher < ActiveRecord::Base

  validates :first_name, :last_name, :email, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  rails_admin do
    navigation_label 'Stammdaten'

    list do
      include_fields :first_name, :last_name, :email
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end

    show do
      field :name
      field :address do
        formatted_value do
          value.gsub( /\n/, '<br>').html_safe
        end
      end
      include_all_fields
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end
  end
end