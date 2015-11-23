class Applying < JsonSerializer

  attribute :by_phone,  Boolean, default: false
  attribute :by_email,  Boolean, default: false
  attribute :by_mail,   Boolean, default: false
  attribute :documents, String

  def by
    attributes.slice(:by_mail, :by_email, :by_phone).select {|k,v| v }.keys
  end

  def self.by(via)
    unless via.in?(%i(by_mail by_email by_phone))
      raise ArgumentError, 'via must be one of :by_mail, :by_email, :by_phone'
    end
    { via => true }.to_json
  end

  module ActsAsApplyable
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods

      def acts_as_applyable(options = {})
        serialize :applying, ::Applying

        ::Applying.attribute_set.each do |attribute|
          delegate attribute.name,       to: :applying, prefix: :applying
          delegate "#{attribute.name}=", to: :applying, prefix: :applying
        end
      end
    end
  end
end
