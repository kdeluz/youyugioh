class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.string :invoice_number, null: false
      t.decimal :total, precision: 10, scale: 2, null: false
      t.decimal :gst, precision: 10, scale: 2
      t.decimal :pst, precision: 10, scale: 2
      t.decimal :hst, precision: 10, scale: 2
      t.decimal :qst, precision: 10, scale: 2

      t.timestamps
    end
  end
end