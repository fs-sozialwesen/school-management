class EducationSubject < ActiveRecord::Base

  validates :name, presence: true

  def display_name
    short_name
  end

  rails_admin do
    navigation_label 'Stammdaten'

    list do
      field :name
      field :short_name
    end
  end
end
