class AddTimeBlockIdToLessons < ActiveRecord::Migration
  def change
    change_table :lessons do |t|
      t.references :time_block, index: true, foreign_key: true
    end

  end
end
