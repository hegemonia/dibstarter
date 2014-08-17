require 'active_support/number_helper'

class Product < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  validates_presence_of :price

  def dibs
    Dib.initial.where(product_id: self.id)
  end

  def conversion_percentage
    [(converted.to_f / threshold.to_f * 100), 100].min
  end

  def converted
    dibs.count
  end

  def threshold
    3
  end

  def outstanding
    [threshold - dibs.count, 0].max
  end

  def dibbed? user
    user && dibs.where(user_id: user.id).first.present?
  end

  def description
    "#{name} (#{number_to_currency(price)})"
  end

  def price_in_cents
    (price * 100).to_i
  end
end
