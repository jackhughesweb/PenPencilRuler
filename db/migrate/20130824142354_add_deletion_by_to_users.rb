class AddDeletionByToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deletion_by, :integer
  end
end
