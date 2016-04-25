class AddCooperationEnums < ActiveRecord::Migration
  def up
    Enum.add_cooperations [
                            'dauerhaft',
                            'befristet',
                            'in Verhandlung',
                            'keine Kooperation gewünscht'
                          ]
  end

  def down
  end
end
