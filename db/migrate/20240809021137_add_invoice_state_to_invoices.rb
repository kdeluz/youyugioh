class AddInvoiceStateToInvoices < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :invoice_state, :string
  end
end
