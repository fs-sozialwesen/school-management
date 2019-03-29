class AddInternManagerToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :intern_manager, :boolean, default: false
  end
end
