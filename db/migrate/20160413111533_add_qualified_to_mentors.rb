class AddQualifiedToMentors < ActiveRecord::Migration
  def change
    add_column :mentors, :qualified, :boolean, default: false
  end
end
