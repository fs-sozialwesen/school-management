class CreateTimeBlocks < ActiveRecord::Migration
  def change
    create_table :time_blocks do |t|
      t.integer :start_hour
      t.integer :start_minute
      t.integer :end_hour
      t.integer :end_minute
      t.integer :position
      t.boolean :active

      t.timestamps null: false
    end
  end
end
