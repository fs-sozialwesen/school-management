class ChangeFkStudentsPeopleToCascade < ActiveRecord::Migration
  def up
    remove_foreign_key :students, :people
    add_foreign_key    :students, :people, on_delete: :cascade
  end

  def down
  end
end
