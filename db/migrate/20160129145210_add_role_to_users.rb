class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_admin, :integer, :null => false, :default => '0'
  end
end
