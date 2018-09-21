class AddInternshipBlockToInternships < ActiveRecord::Migration
  def change
    add_reference :internships, :internship_block, index: true, foreign_key: true
  end
end
