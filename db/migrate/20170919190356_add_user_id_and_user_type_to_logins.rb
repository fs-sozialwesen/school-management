class AddUserIdAndUserTypeToLogins < ActiveRecord::Migration
  def change
    change_table :logins do |t|
      t.integer :user_id,   null: false, index: true, default: 0
      t.string  :user_type, null: false, index: true, default: 'Person'
    end
    reversible do |dir|
      dir.up do
        Login.update_all 'user_id = person_id'
        Student.joins(person: :login).each { |student| student.person.login.update user: student }
      end
    end
  end
end
