class HomeController < ApplicationController
  before_action :fetch_products

  def landing_page
  end

  def get_products
    render json: @products, status: :ok
  end

  private

  def fetch_products
    @products = Product.first(15)
  end
end