class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :type, default: 'Organisation'
      t.string :name, null: false
      t.string :kind
      t.string :contact_person
      t.references :carrier, index: true

      t.string :street
      t.string :zip
      t.string :city

      t.string :email
      t.string :phone
      t.string :mobile
      t.string :fax
      t.string :homepage

      t.text :comments

      t.timestamps null: false
    end
  end
end
