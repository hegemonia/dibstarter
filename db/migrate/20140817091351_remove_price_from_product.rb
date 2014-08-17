class RemovePriceFromProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.remove :price
    end
  end
end
