class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.date :date
      t.references :timetable, index: true, foreign_key: true
      t.references :teacher, index: true, foreign_key: false
      t.references :subject, index: true, foreign_key: true
      t.references :room, index: true, foreign_key: true
      t.references :time_block, index: true, foreign_key: true
      t.datetime :end_time
      t.string :state
      t.string :comments

      t.timestamps null: false
    end
  end
end
