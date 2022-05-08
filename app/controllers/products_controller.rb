class ProductsController < ApplicationController
  def index
    @products = Product.all.newest
    respond_to do |format|
      format.html {}
      format.json { json_response(@products) }
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      successfully_response(object: @product, path: products_path, notice: "Pomyślnie dodano produkt")
    else
      not_valid_response(object: { errors: @product.errors.messages }, action: :new)
    end
  end

  def destroy

  end

  private

  def product_params
    params.require(:product).permit(:name, :symbol, :price, :availability, :max, :attributes)
  end
end