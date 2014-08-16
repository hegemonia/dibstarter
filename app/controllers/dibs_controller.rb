class DibsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @product = Product.find(params[:product_id])
    @dib = Dib.new
  end

  def create
    redirect_to '/'
  end
end
