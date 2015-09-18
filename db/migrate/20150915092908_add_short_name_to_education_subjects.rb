class AddShortNameToEducationSubjects < ActiveRecord::Migration
  def change
    add_column :education_subjects, :short_name, :string
  end
end
