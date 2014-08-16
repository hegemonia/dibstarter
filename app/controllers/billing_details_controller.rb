class BillingDetailsController < ApplicationController
  def index
    @user = current_user
    @billing_detail = BillingDetail.where(user: @user).first
  end
end
