class AddMentorToInternships < ActiveRecord::Migration
  def change
    remove_column :internships, :mentor
    change_table :internships do |t|
      t.references :mentor, index: true, foreign_key: true
    end
  end
end
