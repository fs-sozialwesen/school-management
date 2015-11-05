module RailsAdmin
  module FieldType
    class AddressField < RailsAdmin::Config::Fields::Base
      register_instance_option(:formatted_value) do
        # value.gsub(/\n/, '<br>').html_safe
      end
    end
  end
end
