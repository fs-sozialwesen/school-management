class AddEducationSubjectIdToStudents < ActiveRecord::Migration
  def change
    add_column :students, :education_subject_id, :integer
  end
end
