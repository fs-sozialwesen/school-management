class Manager < ActiveRecord::Base
  belongs_to :person, validate: true, inverse_of: :as_manager
end
