class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.references :person, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
