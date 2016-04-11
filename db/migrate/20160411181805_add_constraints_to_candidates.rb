class AddConstraintsToCandidates < ActiveRecord::Migration
  def change
    change_column_null :candidates, :first_name, false
    change_column_null :candidates, :last_name, false
  end
end
