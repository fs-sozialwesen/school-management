class Mentor < Person

  # belongs_to :carrier,     inverse_of: :mentors
  # belongs_to :institution, inverse_of: :mentors
  has_many :internships,   inverse_of: :mentor

  has_paper_trail

  def name
    "#{first_name} #{last_name}"
  end


  rails_admin do
    navigation_label 'Praktikum'
    parent Institution

  end

end
