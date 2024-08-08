class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index, :show]

  def new
    @order = Order.new
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
    if user_signed_in?
      @order.assign_attributes(current_user.slice(:address_line1, :city, :province, :postal_code, :country))
    end
    @total_amount = calculate_order_total
    @gst, @pst, @hst, @qst, @total_with_taxes = TaxCalculator.calculate_tax(@total_amount, @order.province)
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user if user_signed_in?
    @cart = session[:cart] || {}

    Order.transaction do
      if @order.save
        @cart.each do |product_id, quantity|
          product = Product.find(product_id)
          OrderItem.create!(
            order: @order,
            product: product,
            quantity: quantity,
            price: product.price
          )
        end
        stripe_token = params[:order][:stripe_token]
        process_payment(stripe_token)
        create_invoice(@order)
        session[:cart] = {}
        redirect_to user_invoices_path, notice: 'Order was successfully placed!'
      else
        handle_new_order_view
        render :new
      end
    end
  rescue StandardError => e
    Rails.logger.error "Error in create action: #{e.message}"
    handle_new_order_view
    render :new, alert: 'There was an error processing your order. Please try again.'
  end

  def index
    @orders = current_user.orders.includes(order_items: :product)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:address_line1, :city, :province, :postal_code, :country, order_items_attributes: [:product_id, :quantity])
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
  rescue Stripe::StripeError => e
    Rails.logger.error "Stripe error while processing payment: #{e.message}"
    raise
  end

  def create_invoice(order)
    Invoice.create!(
      user: order.user,
      order: order,
      invoice_number: SecureRandom.hex(10),
      total: @total_with_taxes,
      gst: @gst,
      pst: @pst,
      hst: @hst,
      qst: @qst
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

  def handle_new_order_view
    @order ||= Order.new
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
    @total_amount = calculate_order_total
    @gst, @pst, @hst, @qst, @total_with_taxes = TaxCalculator.calculate_tax(@total_amount, @order.province)
  end
end
