class ApplicationController < ActionController::Base
  before_action :set_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_categories
    @categories = Product.select(:card_type).distinct
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :address_line1, :address_line2, :city, :province, :postal_code, :country])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :address_line1, :address_line2, :city, :province, :postal_code, :country])
  end
end
