class RemoveFkFromStudents < ActiveRecord::Migration
  def up
    remove_foreign_key :candidates, :students
    remove_foreign_key :candidates, :people
  rescue StandardError => e
  end

  def down
    # add_foreign_key :candidates, :students
    # add_foreign_key :candidates, :people
  end
end
