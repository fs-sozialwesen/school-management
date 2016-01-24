class LegacyDatum < ActiveRecord::Base
  serialize :data, Hash

end
