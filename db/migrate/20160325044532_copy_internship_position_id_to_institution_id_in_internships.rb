class CopyInternshipPositionIdToInstitutionIdInInternships < ActiveRecord::Migration
  def up
    execute 'UPDATE internships SET institution_id = internship_position_id'
  end

  def down
  end
end
