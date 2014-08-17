class ProductsController < ApplicationController
  def index
    @products = Product.all.sort_by {|p| [100 - p.conversion_percentage, p.price]}
    @user = current_user
  end

  def show
    @product = Product.find(params[:id])
  end
end
