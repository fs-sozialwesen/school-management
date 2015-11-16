class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :gender
      t.date :date_of_birth
      t.string :place_of_birth

      t.jsonb :address, default: '{}'
      t.jsonb :contact, default: '{}'

      t.timestamps null: false
    end
  end
end
