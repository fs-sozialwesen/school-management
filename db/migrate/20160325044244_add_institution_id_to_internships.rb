class AddInstitutionIdToInternships < ActiveRecord::Migration
  def change
    change_table :internships do |t|
      t.references :institution, index: true, foreign_key: true
    end
  end
end
