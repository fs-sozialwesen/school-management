class Subject < ActiveRecord::Base

  has_many :lessons, inverse_of: :subject

  has_paper_trail

  rails_admin do
    navigation_label I18n.t(:timetable)

    list do
      field :name
      field :comments
    end

    show do
      field :name
      field :comments
    end

  end
end
