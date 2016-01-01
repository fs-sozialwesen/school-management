# This migration comes from acts_as_taggable_on_engine (originally 1)
class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.integer :taggings_count, default: 0
      t.index :name, unique: true
    end

    create_table :taggings do |t|
      t.references :tag

      # You should make sure that the column created is
      # long enough to store the required class names.
      t.references :taggable, polymorphic: true
      t.references :tagger, polymorphic: true

      # Limit is created to prevent MySQL error on index
      # length for MyISAM table type: http://bit.ly/vgW2Ql
      t.string :context, limit: 128

      t.datetime :created_at

      t.index [:taggable_id, :taggable_type, :context]
      t.index [:tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type],
                    unique: true, name: 'taggings_idx'
    end

    ActsAsTaggableOn::Tag.reset_column_information
    # ActsAsTaggableOn::Tag.find_each do |tag|
    #   ActsAsTaggableOn::Tag.reset_counters(tag.id, :taggings)
    # end

  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
