class CreateTimetableSubjects < ActiveRecord::Migration
  def change
    create_table :timetable_subjects do |t|
      t.string :name
      t.string :comments

      t.timestamps null: false
    end
  end
end
