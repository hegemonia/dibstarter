class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.string :name
      t.string :design_id
      t.string :preview_url
      t.timestamps
    end
  end
end
