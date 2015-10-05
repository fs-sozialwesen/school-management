class Person < ActiveRecord::Base

  validates :first_name, :last_name, :email, presence: true


  rails_admin do
    hide
    # navigation_label 'Stammdaten'

  end

end
