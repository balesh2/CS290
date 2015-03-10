class RemoveCreatorFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :creator, :string
  end
end
