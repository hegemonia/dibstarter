require 'active_support/number_helper'

class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  validates_presence_of :price

  def dibbed? user
    user && Dib.where(user_id: user.id, product_id: self.id).first.present?
  end

  def description
    "#{name} (#{number_to_currency(price)})"
  end

  def amount_in_cents
    (price * 100).to_i
  end
end
