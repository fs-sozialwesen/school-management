class Housing < JsonSerializer

  attribute :provided, Boolean, default: false
  attribute :costs,    String

  def self.provided(prov)
    { provided: prov }.to_json
  end


  module ActsAsHousable
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods

      def acts_as_housable(options = {})
        serialize :housing, ::Housing

        ::Housing.attribute_set.each do |attribute|
          delegate attribute.name,       to: :housing, prefix: :housing
          delegate "#{attribute.name}=", to: :housing, prefix: :housing
        end
      end
    end
  end
end
