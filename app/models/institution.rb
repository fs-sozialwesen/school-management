class Institution < ActiveRecord::Base

  belongs_to :carrier, inverse_of: :institutions

  rails_admin do
    navigation_label 'Praktikum'
    parent Carrier
  end
end
