class CreateEducationSubjects < ActiveRecord::Migration
  def change
    create_table :education_subjects do |t|
      t.integer :school_id, index: true, foreign_key: true
      t.string :name
      t.string :short_name

      t.timestamps null: false
    end
  end
end
