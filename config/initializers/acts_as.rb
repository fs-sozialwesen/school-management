
ActiveRecord::Base.send :include, Address::ActsAsAddressable
ActiveRecord::Base.send :include, Contact::ActsAsContactable
ActiveRecord::Base.send :include, Housing::ActsAsHousable
ActiveRecord::Base.send :include, Applying::ActsAsApplyable
