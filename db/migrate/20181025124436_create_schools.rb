class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.jsonb :address, default: '{}'
      t.jsonb :contact, default: '{}'
    end
  end
end
