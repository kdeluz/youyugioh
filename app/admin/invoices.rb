
ActiveAdmin.register Invoice do
  permit_params :user_id, :order_id, :invoice_number, :total, :gst, :pst, :hst, :qst, :invoice_state

  index do
    selectable_column
    id_column
    column :invoice_number
    column :total
    column :gst
    column :pst
    column :hst
    column :qst
    column :invoice_state do |invoice|
      status_tag invoice.invoice_state, label: invoice.invoice_state.humanize
    end
    column :created_at
    actions do |invoice|
      item "Mark as Shipped", mark_as_shipped_admin_invoice_path(invoice), method: :put if invoice.paid?
    end
  end

  show do
    attributes_table do
      row :invoice_number
      row :total
      row :gst
      row :pst
      row :hst
      row :qst
      row :invoice_state do |invoice|
        status_tag invoice.invoice_state, label: invoice.invoice_state.humanize
      end
      row :created_at
      row :updated_at
    end

    panel "Order Details" do
      attributes_table_for invoice.order do
        row :id
        row :address_line1
        row :city
        row :province
        row :postal_code
        row :country
      end
    end

    panel "Order Items" do
      table_for invoice.order.order_items do
        column :product
        column :quantity
        column :price
      end
    end
  end

  member_action :mark_as_shipped, method: :put do
    resource.mark_as_shipped
    redirect_to admin_invoice_path(resource), notice: "Invoice marked as shipped!"
  end
end
