class Room < ActiveRecord::Base

  has_paper_trail

  rails_admin do
    navigation_label 'Stundenplan'
  end
end
