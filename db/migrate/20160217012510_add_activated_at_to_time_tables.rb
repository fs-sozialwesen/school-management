class AddActivatedAtToTimeTables < ActiveRecord::Migration
  def change
    change_table :time_tables do |t|
      t.date :activated_at
    end
  end
end
