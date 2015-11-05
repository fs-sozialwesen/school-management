class CreateInternshipOffers < ActiveRecord::Migration
  def change
    create_table :internship_offers do |t|
      t.string :name
      t.references :carrier, index: true, foreign_key: true
      t.text :description
      t.string :email
      t.string :work_area
      t.string :city
      t.string :street
      t.string :zip
      t.string :phone
      t.string :fax
      t.string :homepage
      t.string :contact_person
      t.boolean :accommodation
      t.text :accommodation_details
      t.text :application_documents

      t.timestamps null: false
    end
  end
end
