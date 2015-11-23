class Role < ActiveRecord::Base
  class Mentor < Role
    has_many :internships, inverse_of: :mentor
  end

  # rails_admin do
  #   hide
  # end
end
