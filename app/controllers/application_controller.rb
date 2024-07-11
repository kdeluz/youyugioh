class ApplicationController < ActionController::Base
    before_action :set_categories
  
    private
  
    def set_categories
      @categories = Product.select(:card_type).distinct
    end
  end
    
  class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?
  
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    def logged_in?
      !!current_user
    end
  end
  