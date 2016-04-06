class ResetInstitutionsPkSequence < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.reset_pk_sequence!(Institution.table_name)
  end

  def down
  end
end
