class AddSingleAddressFieldsToAddressables < ActiveRecord::Migration
  def change
    remove_column :students, :address
    add_column    :students, :street, :string
    add_column    :students, :zip,    :string, limit: 10
    add_column    :students, :city,   :string

    remove_column :teachers, :address
    add_column    :teachers, :street, :string
    add_column    :teachers, :zip,    :string, limit: 10
    add_column    :teachers, :city,   :string
  end
end
