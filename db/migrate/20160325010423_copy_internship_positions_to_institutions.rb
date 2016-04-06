class CopyInternshipPositionsToInstitutions < ActiveRecord::Migration
  def up
    execute 'insert into institutions select * from internship_positions'
  end

  def down
  end
end
