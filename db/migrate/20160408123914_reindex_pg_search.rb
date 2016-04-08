class ReindexPgSearch < ActiveRecord::Migration
  def up
    PgSearch::Multisearch.rebuild(Person)
    PgSearch::Multisearch.rebuild(Organisation)
    PgSearch::Multisearch.rebuild(Institution)
  end

  def down
  end
end
