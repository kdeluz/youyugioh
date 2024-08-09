class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one :invoice

  enum order_state: { new_order: 0, paid: 1, shipped: 2 }

  after_initialize :set_default_state, if: :new_record?

  def calculate_order_total
    total = 0
    self.order_items.each do |item|
      total += item.product.price * item.quantity
    end
    total
  end

  def create_invoice
    Invoice.create!(
      user: self.user,
      order: self,
      invoice_number: SecureRandom.hex(10),
      total: self.total,
      gst: self.gst,
      pst: self.pst,
      hst: self.hst,
      qst: self.qst,
      invoice_state: self.order_state == 'paid' ? 'paid' : 'new'
    )
  end

  def set_default_state
    self.order_state ||= 'new_order'
  end

  def mark_as_paid
    update(order_state: 'paid')
    create_invoice
  end

  def mark_as_shipped
    update(order_state: 'shipped')
    invoice.update(invoice_state: 'shipped') if invoice
  end
end
