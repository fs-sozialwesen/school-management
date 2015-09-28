class DropMentors < ActiveRecord::Migration
  def change
    remove_foreign_key :internships, :mentors
    remove_index :internships, :mentor_id
    drop_table :mentors
  end
end
