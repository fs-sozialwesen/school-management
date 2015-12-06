class LegacyDatum < ActiveRecord::Base
  serialize :data, Hash

  rails_admin do

    hide

    navigation_label I18n.t(:basic_data)

    configure(:old_table) do
      label 'alte Tabelle'
      column_width 150
    end

    configure(:old_id) do
      label 'alte ID'
      column_width 90
    end

    configure :data do
      label 'Daten'
      pretty_value do
        value.each_with_object([]) do |(k, v), val|
          val << "<label style='display: inline-block; min-width: 160px;'>#{k}:</label> #{v}"
        end.join('<br>').html_safe
      end
    end

    list do
      field :old_table
      field :old_id
      field :data
    end
  end
end
