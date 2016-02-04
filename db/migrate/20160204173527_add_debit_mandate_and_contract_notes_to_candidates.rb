class AddDebitMandateAndContractNotesToCandidates < ActiveRecord::Migration
  def change
    change_table :candidates do |t|
      t.boolean :debit_mandate, default: false
      t.text :contract_notes
    end
  end
end
