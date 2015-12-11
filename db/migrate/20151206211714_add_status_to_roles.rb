class AddStatusToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :status, :string
  end
end
