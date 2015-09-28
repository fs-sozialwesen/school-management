class DropTeachers < ActiveRecord::Migration
  def change
    remove_foreign_key :courses, :teachers
    remove_index :courses, :teacher_id
    drop_table :teachers
  end
end
