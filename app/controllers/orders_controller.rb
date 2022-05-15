class OrdersController < ApplicationController
  def index
    @orders = Order.all.newest
  end

  def new
    @order = Order.new
    @products = Product.newest
  end

  def create

  end
end