class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index, :show]

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
    @total_amount = calculate_order_total
    @gst, @pst, @hst, @qst, @total_with_taxes = TaxCalculator.calculate_tax(@total_amount, @order.province)
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user if user_signed_in?
    @cart = session[:cart] || {}

    @cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.build(product: product, quantity: quantity, price: product.price)
    end

    @total_amount = calculate_order_total
    @gst, @pst, @hst, @qst, @total_with_taxes = TaxCalculator.calculate_tax(@total_amount, @order.province)

    @order.total = @total_with_taxes
    @order.gst = @gst
    @order.pst = @pst
    @order.hst = @hst
    @order.qst = @qst

    if @order.save
      stripe_token = params[:order][:stripe_token]
      process_payment(stripe_token)
      @order.create_invoice
      session[:cart] = {}
      redirect_to user_invoices_path, notice: 'Order was successfully placed!'
    else
      handle_new_order_view
      render :new
    end
  rescue StandardError => e
    Rails.logger.error "Error in create action: #{e.message}"
    handle_new_order_view
    render :new, alert: 'There was an error processing your order. Please try again.'
  end

  private

  def order_params
    params.require(:order).permit(:address_line1, :city, :province, :postal_code, :country)
  end

  def process_payment(stripe_token)
    @total_amount = calculate_order_total
    @gst, @pst, @hst, @qst, @total_with_taxes = TaxCalculator.calculate_tax(@total_amount, @order.province)
    charge = Stripe::Charge.create(
      amount: (@total_with_taxes * 100).to_i,
      currency: 'cad',
      source: stripe_token,
      description: "Order ##{@order.id}"
    )
    Rails.logger.info "Stripe charge created: #{charge.id}"
    @order.mark_as_paid if charge.paid
  rescue Stripe::StripeError => e
    Rails.logger.error "Stripe error while processing payment: #{e.message}"
    raise
  end

  def calculate_order_total
    total = 0
    @cart.each do |product_id, quantity|
      product = Product.find(product_id)
      total += product.price * quantity
    end
    total
  end

  def handle_new_order_view
    @order ||= Order.new
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
    @total_amount = calculate_order_total
    @gst, @pst, @hst, @qst, @total_with_taxes = TaxCalculator.calculate_tax(@total_amount, @order.province)
  end
end