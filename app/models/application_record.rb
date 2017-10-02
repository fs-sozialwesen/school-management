class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include Address::ActsAsAddressable
  include Contact::ActsAsContactable
  include Housing::ActsAsHousable
  include Applying::ActsAsApplyable
end
