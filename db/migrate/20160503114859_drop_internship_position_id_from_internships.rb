class DropInternshipPositionIdFromInternships < ActiveRecord::Migration
  def up
    remove_column :internships, :internship_position_id
  end

  def down
    add_column :internships, :internship_position_id, :integer
  end
end
