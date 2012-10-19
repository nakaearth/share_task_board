class AddIndexJobCountGradeMasters < ActiveRecord::Migration
  def change
    add_index :grade_masters, [:job_count]
  end
end
