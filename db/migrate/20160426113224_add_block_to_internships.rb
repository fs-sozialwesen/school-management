class AddBlockToInternships < ActiveRecord::Migration
  def change
    add_column :internships, :block, :string
  end
end
