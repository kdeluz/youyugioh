class Cart < ApplicationRecord
    has_many :cart_items, dependent: :destroy
  
    def add_product(product)
      current_item = cart_items.find_by(product_id: product.id)
      if current_item
        current_item.increment(:quantity)
      else
        current_item = cart_items.build(product: product)
      end
      current_item.save
    end
  
    def remove_product(product_id)
      current_item = cart_items.find_by(product_id: product_id)
      current_item.destroy if current_item
    end
  
    def update_product(product_id, quantity)
      current_item = cart_items.find_by(product_id: product_id)
      current_item.update(quantity: quantity) if current_item
    end
  end
  