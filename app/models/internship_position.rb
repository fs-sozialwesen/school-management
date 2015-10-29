class InternshipPosition < ActiveRecord::Base

  belongs_to :education_subject
  belongs_to :institution, inverse_of: :internship_positions
  has_many :internships, inverse_of: :internship_position

  has_paper_trail

  rails_admin do
    parent Institution

    configure :work_area, :enum do
      enum { ['Kindertagesstätten', 'Hort', 'Heim', 'Tagesgruppe', 'offene Kinder- und Jugendarbeit', 'Psychiatrie', 'Schule'] }
    end

    list do
      field :name, :self_link
      field :education_subject
      field :institution
      field :year
      field :accommodation
    end

    edit do
      exclude_fields :internships
    end

    show do
      field :name
      field :education_subject
      field :institution
      field :comments
      field :accommodation
    end

  end
end
