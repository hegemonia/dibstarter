class DibsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @product = Product.find(params[:product_id])
    @dib = Dib.new
  end

  def create
    @billing_detail = BillingDetail.new(user: current_user, payment_gateway: 'stripe', payment_token: params['stripeToken'])
    @billing_detail.save!
    @dib = Dib.new(user_id: current_user.id, billing_detail_id: @billing_detail.id, product_id: params[:product_id])
    @dib.save!

    redirect_to controller: 'products'
  end
end
