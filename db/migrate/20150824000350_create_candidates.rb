class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.references :person, index: true, foreign_key: true
      t.boolean :active
      t.jsonb :options, default: '{}'
      t.string :status

      t.timestamps null: false
    end
  end
end
