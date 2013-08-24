class AddDeletionAllowedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deletion_allowed, :boolean, default: false
  end
end
