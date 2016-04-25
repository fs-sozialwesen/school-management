class AddContractToInternships < ActiveRecord::Migration
  def change
    add_column :internships, :contract_proved, :boolean
  end
end
