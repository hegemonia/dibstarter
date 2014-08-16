class AddDesignTypeToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.string :design_type
    end
  end
end
