class AddMediumColorSizeToDib < ActiveRecord::Migration
  def change
    change_table :dibs do |t|
      t.string :medium
      t.string :color
      t.string :size
    end
  end
end
