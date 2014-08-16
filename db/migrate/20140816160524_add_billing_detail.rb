class AddBillingDetail < ActiveRecord::Migration
  def change
    create_table :billing_details do |t|
      t.belongs_to :user
      t.string :payment_gateway
      t.string :payment_token
      t.timestamps
    end
  end
end
