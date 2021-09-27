class AddPersonColumnsToMentors < ActiveRecord::Migration
  def change
    change_table :mentors do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.jsonb :address, default: {}
      t.jsonb :contact, default: {}
      t.boolean :archived, default: false
    end
  end
end
