class CreateEducationSubjects < ActiveRecord::Migration
  def change
    create_table :education_subjects do |t|
      t.string :name
      t.string :short_name

      t.timestamps null: false
    end
  end
end
