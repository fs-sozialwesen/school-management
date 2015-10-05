module RailsAdmin
  module FieldType
    class SelfLinkField < RailsAdmin::Config::Fields::Base
      register_instance_option(:formatted_value) do
        model_name  = bindings[:controller].params[:model_name]
        url_options = {model_name: model_name, id: bindings[:object].id}
        url         = bindings[:view].rails_admin.show_path url_options
        bindings[:view].link_to value, url
      end
    end
  end
end
