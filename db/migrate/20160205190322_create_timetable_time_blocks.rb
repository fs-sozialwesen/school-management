class CreateTimetableTimeBlocks < ActiveRecord::Migration
  def change
    create_table :timetable_time_blocks do |t|
      t.time :start_time
      t.time :end_time

      t.timestamps null: false
    end
  end
end
