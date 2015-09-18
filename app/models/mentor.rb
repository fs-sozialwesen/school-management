class Mentor < ActiveRecord::Base

  belongs_to :carrier,     inverse_of: :mentors
  belongs_to :institution, inverse_of: :mentors

  def name
    "#{first_name} #{last_name}"
  end


  rails_admin do
    navigation_label 'Praktikum'
    parent Institution

  end

end
