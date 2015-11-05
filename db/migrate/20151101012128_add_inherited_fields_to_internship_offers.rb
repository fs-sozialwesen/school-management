class AddInheritedFieldsToInternshipOffers < ActiveRecord::Migration
  def change
    change_table :internship_offers do |t|
      t.string :type
      t.references :internship_offer, index: true, foreign_key: true
      t.references :education_subject, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :number_of_positions, default: 1
    end
  end
end
