class Contract < ActiveRecord::Base
  belongs_to :role
  belongs_to :first_party,  polymorphic: true
  belongs_to :second_party, polymorphic: true
end
