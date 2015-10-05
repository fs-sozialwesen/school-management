class CreateLegacyData < ActiveRecord::Migration
  def change
    create_table :legacy_data do |t|
      t.string :old_table
      t.integer :old_id
      t.text :data

      t.timestamps null: false
    end
  end
end
