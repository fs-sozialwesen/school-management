class CreateInternshipOffers < ActiveRecord::Migration
  def change
    create_table :internship_offers do |t|
      t.string :name
      t.references :organisation, index: true, foreign_key: true
      t.text :description
      t.string :work_area

      t.string :street
      t.string :zip
      t.string :city

      t.string :email
      t.string :phone
      t.string :mobile
      t.string :fax
      t.string :homepage

      t.string :contact_person
      t.jsonb :accommodation_options
      t.jsonb :application_options

      t.timestamps null: false
    end
  end
end