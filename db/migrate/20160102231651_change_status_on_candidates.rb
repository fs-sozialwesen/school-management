class ChangeStatusOnCandidates < ActiveRecord::Migration
  def change
    change_table :candidates do |t|
      t.remove :status
      t.integer :status, default: 0
    end
  end
end
