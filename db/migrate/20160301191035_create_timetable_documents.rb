class CreateTimetableDocuments < ActiveRecord::Migration
  def change
    create_table :timetable_documents do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :year
      t.attachment :document

      t.timestamps null: false
    end
  end
end
