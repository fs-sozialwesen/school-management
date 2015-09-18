class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
      t.string :first_name
      t.string :last_name
      t.references :carrier, index: true, foreign_key: true
      t.references :institution, index: true, foreign_key: true
      t.string :email
      t.string :phone
      t.text :comments

      t.timestamps null: false
    end
  end
end
