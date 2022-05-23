class HomeController < ApplicationController
  def landing_page
    @products = Product.first(10)
  end
end