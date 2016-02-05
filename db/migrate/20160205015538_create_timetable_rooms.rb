class CreateTimetableRooms < ActiveRecord::Migration
  def change
    create_table :timetable_rooms do |t|
      t.string :name
      t.string :comments

      t.timestamps null: false
    end
  end
end
