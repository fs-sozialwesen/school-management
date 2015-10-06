class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :timetable, index: true, foreign_key: true
      t.references :teacher, index: true, foreign_key: false
      t.references :subject, index: true, foreign_key: true
      t.references :room, index: true, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :comments

      t.timestamps null: false
    end
  end
end
