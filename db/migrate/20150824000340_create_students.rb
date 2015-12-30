class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :person, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true
      t.boolean :active

      t.timestamps null: false
    end
  end
end
