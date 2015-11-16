class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :type, default: 'Organisation'
      t.string :name, null: false
      t.string :kind
      t.references :carrier, index: true
      t.text :comments

      t.jsonb :address, default: '{}'
      t.jsonb :contact, default: '{}'


      t.timestamps null: false
    end
  end
end
