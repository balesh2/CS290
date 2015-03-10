class ChangeUserAdminDefault < ActiveRecord::Migration
  def change
    def up
      change_column :users, :admin, :boolean, :default => false
    end
    def down
      change_column :users, :admin, :boolean, :default => nil
    end
  end
end
