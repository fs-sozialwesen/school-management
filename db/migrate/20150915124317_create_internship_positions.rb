class CreateInternshipPositions < ActiveRecord::Migration
  def change
    create_table :internship_positions do |t|
      t.string :name
      t.references :institution, index: true, foreign_key: true
      t.string :work_area
      t.text :description
      t.boolean :accommodation
      t.integer :kind_of_application
      t.integer :year
      t.string :application_documents
      t.string :contact_person
      t.text :comments

      t.timestamps null: false
    end
  end
end
