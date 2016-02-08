class CreateTimeTables < ActiveRecord::Migration
  def change
    create_table :time_tables do |t|
      t.references :course, index: true, foreign_key: true
      t.date :start_date
      t.text :comments

      t.timestamps null: false
    end
  end
end
