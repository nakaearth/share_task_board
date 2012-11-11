class AddIndexToJobsUserIdGroupId < ActiveRecord::Migration
  def change
    add_index :jobs, [:user_id, :group_id]
  end
end
