class AddExchangeToInternships < ActiveRecord::Migration
  def change
    add_column :internships, :exchange, :boolean, default: false
  end
end
