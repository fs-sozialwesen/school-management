class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :type
      t.references :role,         foreign_key: true, index: true
      t.references :first_party,  polymorphic: true, index: true
      t.references :second_party, polymorphic: true, index: true
      t.date :start_date
      t.date :end_date
      t.text :text
      t.text :comments
      t.string :state

      t.timestamps null: false
    end
  end
end
