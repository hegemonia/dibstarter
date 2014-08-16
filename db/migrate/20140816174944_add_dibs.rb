class AddDibs < ActiveRecord::Migration
  def change
    create_table :dibs do |t|
      t.integer :billing_detail_id
      t.integer :product_id

      t.timestamps
    end
  end
end
