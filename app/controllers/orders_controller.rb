class OrdersController < ApplicationController
  def new
    @order = Order.new
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
    params.require(:order).permit(:address, :province, :postal_code)
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
