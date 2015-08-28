class AddEducationSubjectIdToCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :education_subject
    add_column :courses, :education_subject_id, :integer
  end

  def down
    add_column :courses, :education_subject, :string
    remove_column :courses, :education_subject_id
  end
end
