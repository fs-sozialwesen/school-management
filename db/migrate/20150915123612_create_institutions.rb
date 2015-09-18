class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.references :carrier, index: true, foreign_key: true
      t.string :street
      t.string :zip
      t.string :city
      t.string :county
      t.string :email
      t.string :phone
      t.string :fax
      t.string :contact_person
      t.string :homepage
      t.text :comments

      t.timestamps null: false
    end
  end
end
