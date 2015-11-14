class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :organisation, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.string :type, index: true

      t.timestamps null: false
    end
  end
end
