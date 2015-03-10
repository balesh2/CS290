class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null:false, default: ""
      t.string :description
      t.string :creator, null:false, default: ""
      t.string :photo
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
