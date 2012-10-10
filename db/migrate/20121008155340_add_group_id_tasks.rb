class AddGroupIdTasks < ActiveRecord::Migration
  def up
    add_column :tasks, :group_id,:integer, :default=>0, :null=>false
  end

  def down
    remove_column :tasks,:group_id
  end
end
