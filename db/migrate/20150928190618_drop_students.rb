class DropStudents < ActiveRecord::Migration
  def change
    remove_foreign_key :internships, :student
    remove_index :internships, :student_id
    drop_table :students
  end
end
