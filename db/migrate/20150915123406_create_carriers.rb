class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :name
      t.string :street
      t.string :zip
      t.string :city
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
