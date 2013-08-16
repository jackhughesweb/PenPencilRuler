class ChangeNotesToText < ActiveRecord::Migration
  def up
    change_column :notes, :text, :text, :limit => nil
  end

  def down
    change_column :notes, :text, :string, :limit => 255
  end
end
