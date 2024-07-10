class ApplicationController < ActionController::Base
    before_action :set_categories
  
    private
  
    def set_categories
      @categories = Product.select(:card_type).distinct
    end
  end
  