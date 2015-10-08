class AddDateToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :date, :date, after: :id
    add_column :lessons, :state, :string
    remove_column :lessons, :start_time
    remove_column :lessons, :end_time
  end
end
