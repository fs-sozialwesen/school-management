class CreateEnums < ActiveRecord::Migration
  def change
    create_table :enums do |t|
      t.string :name, null: false
      t.string :value
    end
    add_index :enums, :name
  end
end
