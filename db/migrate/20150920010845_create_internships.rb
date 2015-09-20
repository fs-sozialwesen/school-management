class CreateInternships < ActiveRecord::Migration
  def change
    create_table :internships do |t|
      t.references :student, index: true, foreign_key: true
      t.references :internship_position, index: true, foreign_key: true
      t.references :mentor, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :state

      t.timestamps null: false
    end
  end
end
