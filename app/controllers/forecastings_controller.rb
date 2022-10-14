class ForecastingsController < ApplicationController

  def index
    @products = Product.where("percent_resource < ?", 100).where("weekly_consumption > ?", 0)
  end

  def show

  end
end
