class AddIsSuspendedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_suspended, :boolean, default: false
  end
end
