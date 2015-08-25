module RailsAdmin
  module FieldType
    class EmailField < RailsAdmin::Config::Fields::Base
      register_instance_option(:formatted_value) do
        bindings[:view].content_tag(:a, value, {href: "mailto:#{value}"})
      end
    end
  end
end
