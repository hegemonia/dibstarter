class BillingDetailsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @billing_detail = BillingDetail.where(user: @user).first
  end
end
