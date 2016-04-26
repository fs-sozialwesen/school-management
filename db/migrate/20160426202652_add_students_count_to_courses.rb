class AddStudentsCountToCourses < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.integer :students_count
      t.integer :time_tables_count
    end
  end
end
