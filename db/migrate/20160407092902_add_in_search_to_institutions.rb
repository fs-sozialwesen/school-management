class AddInSearchToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :in_search, :boolean, default: true
  end
end
