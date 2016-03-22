class CreateMentors < ActiveRecord::Migration
  def change
    create_table :mentors do |t|
      t.references :person, index: true, foreign_key: true
      t.references :organisation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
