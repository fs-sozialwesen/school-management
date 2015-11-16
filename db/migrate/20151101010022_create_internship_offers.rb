class CreateInternshipOffers < ActiveRecord::Migration
  def change
    create_table :internship_offers do |t|
      t.string :name
      t.references :organisation, index: true, foreign_key: true
      t.text :description
      t.string :work_area

      t.jsonb :address, default: '{}'
      t.jsonb :contact, default: '{}'
      t.jsonb :housing, default: '{}'
      t.jsonb :applying, default: '{}'

      t.timestamps null: false
    end
  end
end
