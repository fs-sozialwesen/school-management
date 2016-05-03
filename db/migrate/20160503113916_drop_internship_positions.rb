class DropInternshipPositions < ActiveRecord::Migration
  def up
    remove_foreign_key :internships, :internship_positions
    drop_table :internship_positions
  end

  def down
    create_table :internship_positions do |t|
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
    add_foreign_key :internships, :internship_positions
  end
end
