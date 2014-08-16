class AddAddressToBilling < ActiveRecord::Migration
  def change
    change_table :billing_details do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
    end
  end
end
