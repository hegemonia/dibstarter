class Dib < ActiveRecord::Base
  belongs_to :billing_detail
  has_one :product
  has_one :user
end
