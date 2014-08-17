class DibsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
    @product = Product.find(params[:product_id])
    @sizes = Size.all
    @dib = Dib.new
  end

  def create
    product = Product.find(params[:product_id])
    billing_detail = BillingDetail.new(
      user: current_user,
      payment_gateway: 'stripe',
      payment_token: params[:stripeToken],
      name: params[:billing_detail_name],
      address1: params[:billing_detail_address1],
      address2: params[:billing_detail_address2],
      city: params[:billing_detail_city],
      state: params[:billing_detail_state],
      zip: params[:billing_detail_zip]
    )
    billing_detail.save!
    dib = Dib.new(
      user_id: current_user.id,
      billing_detail_id: billing_detail.id,
      product_id: params[:product_id],
      medium: 'american-apparel-t-shirt',
      color: product.color,
      size: params[:size]
    )
    dib.save!
    DibPlacementMailer.send_dib_placed_email(dib)
    redirect_to controller: 'products'
  end
end
