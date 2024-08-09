ActiveAdmin.register Invoice do
  permit_params :user_id, :order_id, :invoice_number, :total, :gst, :pst, :hst, :qst, :invoice_state

  # Define the possible states
  INVOICE_STATES = ['new', 'paid', 'shipped'].freeze

  index do
    selectable_column
    id_column
    column :user do |invoice|
      invoice.user.email
    end
    column :invoice_number
    column :total
    column :gst
    column :pst
    column :hst
    column :qst
    column :invoice_state do |invoice|
      status = invoice.invoice_state || 'unknown'
      status_tag status, label: status.humanize
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
        status = invoice.invoice_state || 'unknown'
        status_tag status, label: status.humanize
      end
      row :created_at
      row :updated_at
    end

    panel "Order Details" do
      attributes_table_for invoice.order do
        row :id
        row :user do
          invoice.user.email
        end
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

  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.all.collect { |u| [u.email, u.id] }
      f.input :order, as: :select, collection: Order.all.collect { |o| ["Order ##{o.id}", o.id] }
      f.input :invoice_number
      f.input :total
      f.input :gst
      f.input :pst
      f.input :hst
      f.input :qst
      f.input :invoice_state, as: :select, collection: INVOICE_STATES
    end
    f.actions
  end

  member_action :mark_as_shipped, method: :put do
    resource.mark_as_shipped
    redirect_to admin_invoice_path(resource), notice: "Invoice marked as shipped!"
  end

  controller do
    def update
      if params[:invoice][:invoice_state] == 'paid'
        resource.mark_as_paid
      end
      super
    end
  end
end
