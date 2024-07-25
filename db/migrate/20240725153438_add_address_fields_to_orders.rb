class AddAddressFieldsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :address_line1, :string
    add_column :orders, :city, :string
    add_column :orders, :province, :string
    add_column :orders, :postal_code, :string
    add_column :orders, :country, :string
  end
end
