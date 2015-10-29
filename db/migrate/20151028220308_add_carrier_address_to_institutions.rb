class AddCarrierAddressToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :carrier_address, :boolean, default: true
  end
end
