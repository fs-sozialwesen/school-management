class Organisation < ActiveRecord::Base
  class School < Organisation

    has_many :students, class_name: 'Role::Student', inverse_of: :school

    rails_admin do
      configure(:city) { pretty_value { bindings[:object].address.city } }
      list do
        field :name
        field :city
        field :carrier
      end
    end

  end
end
