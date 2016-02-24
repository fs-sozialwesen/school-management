class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :time_table, index: true, foreign_key: true
      t.references :teacher, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.references :room, index: true, foreign_key: true
      t.references :time_block, index: true, foreign_key: true
      t.integer :weekday
      t.string :comments
      t.string :color

      t.timestamps null: false
    end
  end
end
