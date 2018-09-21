class CreateInternshipBlocks < ActiveRecord::Migration
  def change
    create_table :internship_blocks do |t|
      t.string :name
      t.integer :course_year
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
