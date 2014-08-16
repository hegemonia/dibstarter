class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
    @user = current_user
  end

  def show
    @product = Product.find(params[:id])
  end
end
