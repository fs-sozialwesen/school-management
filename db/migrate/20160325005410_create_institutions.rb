class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.references :organisation, index: true, foreign_key: true

      t.text :description
      t.string :work_area

      t.date :start_date
      t.date :end_date
      t.integer :positions_count, default: 1

      t.jsonb :address,   default: '{}'
      t.jsonb :contact,   default: '{}'
      t.jsonb :housing,   default: '{}'
      t.jsonb :applying,  default: '{}'

      t.timestamps null: false
    end
  end
end
