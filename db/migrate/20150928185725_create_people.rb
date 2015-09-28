class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :mobile
      t.string :street
      t.string :zip
      t.string :city
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :gender

      t.timestamps null: false
    end
  end
end
