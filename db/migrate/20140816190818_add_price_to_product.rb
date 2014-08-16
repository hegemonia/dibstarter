class AddPriceToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.decimal :price
    end
  end
end
