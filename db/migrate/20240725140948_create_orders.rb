class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.string :address
      t.string :province
      t.string :postal_code
      t.timestamps
    end
  end
end