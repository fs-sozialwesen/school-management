class AddPersonFieldsToStudents < ActiveRecord::Migration
  def change
    change_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :date_of_birth
      t.string :place_of_birth
      t.jsonb :address, default: {}
      t.jsonb :contact, default: {}
    end
  end
end
