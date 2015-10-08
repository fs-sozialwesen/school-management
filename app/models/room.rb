class Room < ActiveRecord::Base

  has_many :lessons, inverse_of: :room

  has_paper_trail

  rails_admin do
    navigation_label I18n.t(:timetable)
  end
end
