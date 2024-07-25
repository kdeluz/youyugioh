class CartsController < ApplicationController
  def show
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
  end

  def add_item
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    session[:cart] ||= {}
    cart = session[:cart]
    if cart[product_id]
      cart[product_id] += quantity
    else
      cart[product_id] = quantity
    end
    redirect_to cart_path
  end

  def remove_item
    product_id = params[:product_id].to_s
    session[:cart].delete(product_id)
    redirect_to cart_path
  end

  def update_quantity
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    if quantity > 0
      session[:cart][product_id] = quantity
    else
      session[:cart].delete(product_id)
    end
    redirect_to cart_path
  end
end
