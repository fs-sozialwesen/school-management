class AddFieldsToOrganisations < ActiveRecord::Migration
  def change
    add_column :organisations, :cooperation, :string
    add_column :organisations, :coop_notes, :string
  end
end
