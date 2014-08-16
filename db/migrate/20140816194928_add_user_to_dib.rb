class AddUserToDib < ActiveRecord::Migration
  def change
    change_table :dibs do |t|
      t.integer :user_id
    end
  end
end
