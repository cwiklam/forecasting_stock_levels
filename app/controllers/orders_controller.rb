class OrdersController < ApplicationController
  def index
    @orders = Order.all.newest
  end

  def new
    @order = Order.new
    @products = Product.newest
  end

  def create
    @order = Order.new(order_params)
    @order.order_number = "#{DateTime.now.strftime('%Y/%m/%d/%H%M%S%L')}"
    if @order.save
      redirect_to orders_path, notice: 'Pomyślnie złożono zamówienie'
    else
      @products = Product.newest
      render new
    end
  end

  private

  def order_params
    params.require(:order).permit(product_orders_attributes: [:product_id, :quantity])
  end
end