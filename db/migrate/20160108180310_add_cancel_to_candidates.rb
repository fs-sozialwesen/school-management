class AddCancelToCandidates < ActiveRecord::Migration
  def change
    change_table :candidates do |t|
      t.date :cancel_date
      t.text :cancel_reason
    end
  end
end
