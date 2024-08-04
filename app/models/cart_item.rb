class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    product.price * quantity
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[cart_id created_at id product_id quantity updated_at]
  end
end
