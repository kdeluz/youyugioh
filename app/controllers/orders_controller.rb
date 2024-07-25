class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer = current_customer
    @order.total = current_cart.cart_items.sum { |item| item.quantity * item.product.price }

    if @order.save
      process_payment
      current_cart.cart_items.each do |cart_item|
        OrderItem.create(order: @order, product: cart_item.product, quantity: cart_item.quantity, price: cart_item.product.price)
      end
      session[:cart_id] = nil
      redirect_to root_path, notice: 'Order was successfully placed.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :total, :status)
  end

  def current_customer
    @current_customer ||= Customer.find_or_create_by(id: session[:customer_id])
  end

  def process_payment
    Stripe::Charge.create(
      amount: (@order.total * 100).to_i,
      currency: 'usd',
      source: params[:stripeToken],
      description: "Order ##{@order.id}"
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_order_path
  end
end
