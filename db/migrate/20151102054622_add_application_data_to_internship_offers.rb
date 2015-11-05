class AddApplicationDataToInternshipOffers < ActiveRecord::Migration
  def change
    add_column :internship_offers, :application_options, :jsonb
  end
end
