class Employee < Person

  rails_admin do

    navigation_label 'Stammdaten'

    list do
      field :first_name, :self_link
      field :last_name, :self_link
      field(:email, :email)
      field :city
    end

    show do
      field :first_name
      field :last_name
      field(:email, :email)
      field(:created_at) { date_format :short }
      field(:updated_at) { date_format :short }
    end
  end
end
