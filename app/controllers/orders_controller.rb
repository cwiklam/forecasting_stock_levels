class OrdersController < ApplicationController
  def index
    @orders = Order.all.newest
  end

  def new
    @order    = Order.new
    @products = Product.alphabetically
  end

  def create
    @order              = Order.new(order_params)
    @order.order_number = "#{DateTime.now.strftime('%Y/%m/%d/%H%M%S%L')}"
    if @order.save
      @order.product_orders.each do |po|
        po.product.update!(availability: po.product.availability - po.quantity)
      end
      successfully_response(object: { message: 'Pomyślnie złożono zamówienie' },
                            notice: 'Pomyślnie złożono zamówienie',
                            path:   orders_path)
    else
      @products = Product.newest
      not_valid_response(object: @order, action: 'new')
    end
  end

  private

  def order_params
    params.require(:order).permit(product_orders_attributes: [:product_id, :quantity])
  end
end
