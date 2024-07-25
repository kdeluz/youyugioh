class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  private

  def current_cart
    @current_cart ||= Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @current_cart = Cart.create
    session[:cart_id] = @current_cart.id
    @current_cart
  end
end
