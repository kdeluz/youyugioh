class AddAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :address_line1 unless column_exists? :users, :address_line1
      t.string :address_line2 unless column_exists? :users, :address_line2
      t.string :city unless column_exists? :users, :city
      t.string :province unless column_exists? :users, :province
      t.string :postal_code unless column_exists? :users, :postal_code
      t.string :country unless column_exists? :users, :country
    end
  end
end
