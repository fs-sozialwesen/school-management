class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :gender
      t.date :date_of_birth
      t.string :place_of_birth

      t.string :street
      t.string :zip
      t.string :city

      t.string :email
      t.string :phone
      t.string :mobile
      t.string :fax

      t.timestamps null: false
    end
  end
end
