class Admin::DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin
  
    def index
    end
  
    private
  
    def ensure_admin
      redirect_to root_path unless current_user.id == 1
    end
  end