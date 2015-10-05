class CreateCourseMemberships < ActiveRecord::Migration
  def change
    create_table :course_memberships do |t|
      t.integer :student_id, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.boolean :active

      t.timestamps null: false
    end
  end
end
