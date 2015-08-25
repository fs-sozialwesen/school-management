class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :email
      t.string :phone
      t.date :date_of_birth
      t.string :place_of_birth
      t.text :comments

      t.timestamps null: false
    end
  end
end
