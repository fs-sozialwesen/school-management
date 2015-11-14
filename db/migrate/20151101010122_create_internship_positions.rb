class CreateInternshipPositions < ActiveRecord::Migration
  def change
    create_table :internship_positions do |t|
      t.string :name
      t.references :internship_offer, index: true, foreign_key: true
      t.references :education_subject, index: true, foreign_key: true
      t.text :description

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

      t.date :start_date
      t.date :end_date
      t.integer :number_of_positions, default: 1

      t.timestamps null: false
    end
  end
end
