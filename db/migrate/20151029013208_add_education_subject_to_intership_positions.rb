class AddEducationSubjectToIntershipPositions < ActiveRecord::Migration
  def change
    change_table :internship_positions do |t|
      t.references :education_subject, index: true, foreign_key: true
    end
  end
end
