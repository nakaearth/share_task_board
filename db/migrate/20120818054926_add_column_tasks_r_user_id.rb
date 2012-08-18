class AddColumnTasksRUserId < ActiveRecord::Migration
  def up
    add_column :tasks, :r_user_id ,:integer ,:default=>0, :null=>false
    add_index :tasks,[:r_user_id]
  end

  def down
    remove_column :tasks, :r_user_id
    remove_index :tasks, [:r_user_id]
  end
end
