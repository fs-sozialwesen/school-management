class InternshipPosition < ActiveRecord::Base

  belongs_to :institution, inverse_of: :internship_positions
  has_many :internships, inverse_of: :internship_position

  has_paper_trail

  rails_admin do
    navigation_label 'Praktikum'
    parent Institution

    configure :work_area, :enum do
      enum { ['Kindertagesstätten', 'Hort', 'Heim', 'Tagesgruppe', 'offene Kinder- und Jugendarbeit', 'Psychiatrie', 'Schule'] }
    end

    edit do
      exclude_fields :internships
    end

  end
end
