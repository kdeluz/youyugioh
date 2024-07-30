class InvoicesController < ApplicationController
  before_action :authenticate_user!

  def index
    @invoices = current_user.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end