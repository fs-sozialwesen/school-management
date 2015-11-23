class Contact < JsonSerializer

  attribute :person,   String
  attribute :email,    String
  attribute :phone,    String
  attribute :fax,      String
  attribute :mobile,   String
  attribute :homepage, String


  module ActsAsContactable
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods

      def acts_as_contactable(options = {})
        serialize :contact, ::Contact

        ::Contact.attribute_set.each do |attribute|
          delegate attribute.name, to: :contact
          delegate "#{attribute.name}=", to: :contact
        end

      end
    end
  end
end
