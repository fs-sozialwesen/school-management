class ActivateAllStudents < ActiveRecord::Migration
  def up
    Student.update_all active: true
    Course.find_by(name: 'Dropouts').students.update_all active: false
  end

  def down
  end
end
