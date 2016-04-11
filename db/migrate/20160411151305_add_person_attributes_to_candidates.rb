class AddPersonAttributesToCandidates < ActiveRecord::Migration
  def change
    change_table :candidates do |t|
      t.references :student, index: true, foreign_key: true

      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :date_of_birth
      t.string :place_of_birth

      t.jsonb :address, default: '{}'
      t.jsonb :contact, default: '{}'
    end
  end
end
