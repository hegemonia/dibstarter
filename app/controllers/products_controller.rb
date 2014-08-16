class ProductsController < ApplicationController
  def index
    @products = Product.all
    @user = current_user
  end

  def show
    @product = Product.find(params[:id])
  end
end
