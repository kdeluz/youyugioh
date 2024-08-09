class AddDefaultValueToInvoiceState < ActiveRecord::Migration[6.1]
  def change
    change_column_default :invoices, :invoice_state, 'new'
  end
end
