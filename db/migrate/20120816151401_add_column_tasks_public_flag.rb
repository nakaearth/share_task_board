class AddColumnTasksPublicFlag < ActiveRecord::Migration
  def up
    add_column :tasks, :public_flag, :integer, :default => 0
    add_index :tasks, [:status, :public_flag]
  end

  def down
    remove_column :tasks, :public_flag
    remove_index :tasks, [:status, :public_flag]
  end
end
