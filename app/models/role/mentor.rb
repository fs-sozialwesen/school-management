class Role < ActiveRecord::Base
  class Mentor < Role
    has_many :internships, inverse_of: :mentor
  end
end
