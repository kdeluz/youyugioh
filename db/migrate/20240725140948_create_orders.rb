class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address_line1, null: false
      t.string :city, null: false
      t.string :province, null: false
      t.string :postal_code, null: false
      t.string :country, null: false

      t.timestamps
    end
  end
end
