class CreateEducationSubjects < ActiveRecord::Migration
  def change
    create_table :education_subjects do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
