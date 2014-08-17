class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @user = current_user
  end

  def create_orders
    ScalablePress.new.create_orders

    redirect_to :action => :index
  end

  private

  def ensure_admin!
    redirect_to '/' unless current_user.try(:admin?)
  end
end
