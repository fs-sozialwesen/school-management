class AddColumnsToCandidates < ActiveRecord::Migration
  def change
    change_table :candidates do |t|
      t.boolean :career_changer, default: false
      t.integer :rank
    end
  end
end
