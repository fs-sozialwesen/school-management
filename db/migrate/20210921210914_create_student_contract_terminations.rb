class CreateStudentContractTerminations < ActiveRecord::Migration
  def change
    create_table :student_contract_terminations do |t|
      t.references :student, index: true, foreign_key: true
      t.date :date, null: false
      t.text :notes
      t.string :terminated_by

      t.timestamps null: false
    end
  end
end
