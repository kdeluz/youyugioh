class AddUserIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :user, null: false, foreign_key: true
    remove_column :orders, :customer_id, :integer
  end
end
