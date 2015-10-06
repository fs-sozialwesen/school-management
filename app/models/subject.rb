class Subject < ActiveRecord::Base

  has_paper_trail

  rails_admin do
    navigation_label 'Stammdaten'
  end
end
