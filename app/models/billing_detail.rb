class BillingDetail < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :address1, :state, :zip
end
