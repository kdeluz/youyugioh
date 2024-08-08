module Admin
    class OrdersController < Admin::ApplicationController
      def index
        @orders = Order.includes(:user, order_items: :product)
      end
  
      def show
        @order = Order.find(params[:id])
      end
    end
  end
  