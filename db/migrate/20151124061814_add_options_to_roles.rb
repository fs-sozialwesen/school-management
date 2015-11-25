class AddOptionsToRoles < ActiveRecord::Migration
  def change
    change_table :roles do |t|
      t.jsonb :options, default: '{}'
    end
  end
end
