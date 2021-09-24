class AddArchivedToPeople < ActiveRecord::Migration
  def change
    add_column :people, :archived, :boolean, default: false
  end
end
