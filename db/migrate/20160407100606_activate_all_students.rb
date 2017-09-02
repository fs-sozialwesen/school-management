class ActivateAllStudents < ActiveRecord::Migration
  def up
    Student.update_all active: true
    dropouts = Course.find_by(name: 'Dropouts')
    dropouts.students.update_all active: false if dropouts
  end

  def down
  end
end
