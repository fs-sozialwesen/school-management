class LegacyDatum < ActiveRecord::Base
  serialize :data, Hash

  def self.method_missing(meth_name, *args, &block)
    meth_name = meth_name.to_s
    if meth_name.in? %w(ausbildungsart lehrer klassen azubi)
      where(old_table: meth_name).pluck(:data)
    else
      super meth_name, *args, &block
    end
  end

  rails_admin do

    navigation_label 'Stammdaten'

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
