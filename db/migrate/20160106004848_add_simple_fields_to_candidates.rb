class AddSimpleFieldsToCandidates < ActiveRecord::Migration
  def change
    change_table :candidates do |t|
      t.date :date
      t.text :notes
      t.string :education_subject
      t.integer :year
      t.jsonb :school_graduate,      default: '{}'
      t.jsonb :profession_graduate,  default: '{}'
      t.text :internships
      t.boolean :internships_proved, default: false
      t.jsonb :interview,            default: '{}'
      t.boolean :police_certificate, default: false
      t.date :education_contract_sent
      t.date :education_contract_received
      t.date :internship_contract_sent
      t.date :internship_contract_received
    end
  end
end
