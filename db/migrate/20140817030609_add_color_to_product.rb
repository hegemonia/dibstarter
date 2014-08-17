class AddColorToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.string :color
    end
  end
end
