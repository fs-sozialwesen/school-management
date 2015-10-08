class DropTimetables < ActiveRecord::Migration
  def change
    remove_index :lessons, :timetable_id, column: :timetable_id
    remove_foreign_key :lessons, :timetables
    remove_column :lessons, :timetable_id

    add_column :lessons, :course_id, :integer, index: true
    add_foreign_key :lessons, :courses

    drop_table :timetables
  end
end
