class RemoveAdmin < ActiveRecord::Migration
  def change
    drop_table 'admin' if ActiveRecord::Base.connection.table_exists? 'admin'
  end
end
