class AddArtistToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.string :artist
    end
  end
end
