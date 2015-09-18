class Institution < ActiveRecord::Base

  belongs_to :carrier,            inverse_of: :institutions
  has_many :internship_positions, inverse_of: :institution
  has_many :mentors,              inverse_of: :institution

  rails_admin do
    navigation_label 'Praktikum'
    parent Carrier
  end
end
