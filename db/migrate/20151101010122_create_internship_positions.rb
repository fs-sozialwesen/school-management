class CreateInternshipPositions < ActiveRecord::Migration
  def change
    create_table :internship_positions do |t|
      t.string :name
      t.references :internship_offer, index: true, foreign_key: true
      t.references :education_subject, index: true, foreign_key: true
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :number_of_positions, default: 1

      t.jsonb :address,  default: '{}'
      t.jsonb :contact,  default: '{}'
      t.jsonb :housing,  default: '{}'
      t.jsonb :applying, default: '{}'
      t.jsonb :inherits, default: '{}'

      t.timestamps null: false
    end
  end
end
