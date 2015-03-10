class ChangeLatLongToCoords < ActiveRecord::Migration
  def change
    remove_column  :posts, :lat, :decimal
    remove_column :posts, :long, :decimal
    add_column :posts, :coords, :string
  end
end
