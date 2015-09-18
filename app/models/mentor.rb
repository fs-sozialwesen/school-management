class Mentor < ActiveRecord::Base

  belongs_to :carrier,     inverse_of: :mentors
  belongs_to :institution, inverse_of: :mentors

  rails_admin do
    navigation_label 'Praktikum'
    parent Institution

  end

end
