class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @order = Order.new
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
    if user_signed_in?
      @order.address_line1 = current_user.address_line1
      @order.city = current_user.city
      @order.province = current_user.province
      @order.postal_code = current_user.postal_code
      @order.country = current_user.country
    end
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user if user_signed_in?

    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)

    if @order.save
      @cart.each do |product_id, quantity|
        product = Product.find(product_id)
        @order.order_items.create(product: product, quantity: quantity)
      end
      process_payment
      session[:cart] = {}
      redirect_to root_path, notice: 'Order was successfully placed.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:address_line1, :city, :province, :postal_code, :country, order_items_attributes: [:product_id, :quantity])
  end

  def process_payment
    Stripe::Charge.create(
      amount: (calculate_order_total * 100).to_i,
      currency: 'cad',
      source: params[:stripeToken],
      description: "Order ##{@order.id}"
    )
  end

  def calculate_order_total
    total = 0
    @cart.each do |product_id, quantity|
      product = Product.find(product_id)
      total += product.price * quantity
    end
    total
  end
end
