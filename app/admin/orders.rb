ActiveAdmin.register Order do
    permit_params :user_id, :address_line1, :city, :province, :postal_code, :country, :gst, :pst, :hst, :qst
  
    index do
      selectable_column
      id_column
      column :user
      column :address_line1
      column :city
      column :province
      column :postal_code
      column :country
      column :gst
      column :pst
      column :hst
      column :qst
      column :created_at
      actions
    end
  
    show do
      attributes_table do
        row :user
        row :address_line1
        row :city
        row :province
        row :postal_code
        row :country
        row :gst
        row :pst
        row :hst
        row :qst
        row :created_at
        row :updated_at
      end
  
      panel "Order Items" do
        table_for order.order_items do
          column :product
          column :quantity
          column :price
        end
      end
    end
  end
  