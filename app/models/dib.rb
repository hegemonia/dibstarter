class Dib < ActiveRecord::Base
  has_one :billing_detail
  has_one :product
  has_one :user
end
