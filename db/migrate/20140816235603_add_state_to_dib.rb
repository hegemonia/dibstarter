class AddStateToDib < ActiveRecord::Migration
  def change
    change_table :dibs do |t|
      t.string :state
    end
  end
end
