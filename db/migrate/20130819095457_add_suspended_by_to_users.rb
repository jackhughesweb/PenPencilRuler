class AddSuspendedByToUsers < ActiveRecord::Migration
  def change
    add_column :users, :suspended_by, :integer
  end
end
