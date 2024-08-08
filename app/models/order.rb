class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_one :invoice

  accepts_nested_attributes_for :order_items

  validates :address_line1, :city, :province, :postal_code, :country, presence: true

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
      qst: self.qst
    )
  end
end
