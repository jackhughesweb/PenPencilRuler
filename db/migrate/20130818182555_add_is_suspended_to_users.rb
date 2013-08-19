class AddIsSuspendedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_suspended, :boolean
  end
end
