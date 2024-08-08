ActiveAdmin.register Invoice do
    permit_params :user_id, :order_id, :invoice_number, :total, :gst, :pst, :hst, :qst
  
    index do
      selectable_column
      id_column
      column :invoice_number
      column :total
      column :gst
      column :pst
      column :hst
      column :qst
      column :created_at
      actions
    end
  
    show do
      attributes_table do
        row :invoice_number
        row :total
        row :gst
        row :pst
        row :hst
        row :qst
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
  end
  