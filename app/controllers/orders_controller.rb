class OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
  end

  def create
    @order = Order.new(order_params)
    @order.customer = current_user if user_signed_in?
    if @order.save
      session[:cart] = {}
      redirect_to root_path, notice: 'Order was successfully placed.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :province, :postal_code, order_items_attributes: [:product_id, :quantity])
  end
end
