ActiveAdmin.register Order do
  permit_params :user_id, :address_line1, :city, :province, :postal_code, :country, :gst, :pst, :hst, :qst, :order_state

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
    column :order_state do |order|
      status_tag order.order_state, label: order.order_state.humanize
    end
    column :created_at
    actions do |order|
      item "Mark as Shipped", mark_as_shipped_admin_order_path(order), method: :put if order.paid?
    end
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
      row :order_state do |order|
        status_tag order.order_state, label: order.order_state.humanize
      end
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price
        column "Total Price" do |item|
          number_to_currency(item.price * item.quantity)
        end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs 'Order Details' do
      f.input :user
      f.input :address_line1
      f.input :city
      f.input :province
      f.input :postal_code
      f.input :country
      f.input :gst
      f.input :pst
      f.input :hst
      f.input :qst
      f.input :order_state, as: :select, collection: Order.order_states.keys.map { |k| [k.humanize, k] }
    end
    f.actions
  end

  action_item :mark_as_shipped, only: :show do
    link_to 'Mark as Shipped', mark_as_shipped_admin_order_path(order), method: :put if order.paid?
  end

  member_action :mark_as_shipped, method: :put do
    order = Order.find(params[:id])
    order.mark_as_shipped
    redirect_to admin_order_path(order), notice: "Order marked as shipped"
  end
end
