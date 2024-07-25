class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  validates :address_line1, :city, :province, :postal_code, :country, presence: true

  def calculate_order_total
    total = 0
    self.order_items.each do |item|
      total += item.product.price * item.quantity
    end
    total
  end
end
