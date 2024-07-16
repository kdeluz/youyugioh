# db/migrate/20240716165417_add_address_to_users.rb
class AddAddressToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :address_line1 unless column_exists? :users, :address_line1
      t.string :address_line2 unless column_exists? :users, :address_line2
      t.string :city unless column_exists? :users, :city
      t.string :state unless column_exists? :users, :state
      t.string :postal_code unless column_exists? :users, :postal_code
      t.string :country unless column_exists? :users, :country
    end
  end
end
