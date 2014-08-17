class AddOrderIdAndChargeIdToDib < ActiveRecord::Migration
  def change
    change_table :dibs do |t|
      t.string :order_id
      t.string :charge_id
    end
  end
end
