class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.references :person, index: true, foreign_key: true
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
