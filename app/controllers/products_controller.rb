class ProductsController < ApplicationController
  before_action :set_categories, only: [:index, :category, :sale, :new_products, :recently_updated, :search]

  def index
    @products = Product.all

    # Sorting logic
    case params[:sort]
    when 'alphabetical'
      @products = @products.order(:name)
    when 'price_high_low'
      @products = @products.order(price: :desc)
    when 'price_low_high'
      @products = @products.order(price: :asc)
    end

    @products = @products.page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
  end

  def category
    @products = Product.where(card_type: params[:category]).page(params[:page]).per(12)
    render :index
  end

  def sale
    @products = Product.where(sale: true).page(params[:page]).per(12)
    render :index
  end

  def new_products
    @products = Product.where('created_at >= ?', 3.days.ago).page(params[:page]).per(12)
    render :index
  end

  def recently_updated
    @products = Product.where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago).page(params[:page]).per(12)
    render :index
  end

  def search
    @products = Product.all

    if params[:keyword].present?
      @products = @products.where('name LIKE ? OR description LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    if params[:category].present? && params[:category] != ''
      @products = @products.where(card_type: params[:category])
    end

    # Apply sorting to the search results
    case params[:sort]
    when 'alphabetical'
      @products = @products.order(:name)
    when 'price_high_low'
      @products = @products.order(price: :desc)
    when 'price_low_high'
      @products = @products.order(price: :asc)
    end

    @products = @products.page(params[:page]).per(12)
    render :index
  end
  
  def add_to_cart
    product = Product.find(params[:id])
    quantity = params[:quantity].to_i

    session[:cart] ||= {}
    cart = session[:cart]

    if cart[product.id.to_s]
      cart[product.id.to_s] += quantity
    else
      cart[product.id.to_s] = quantity
    end

    redirect_to cart_path
  end

  private

  def set_categories
    @categories = Product.select(:card_type).distinct
  end
end
