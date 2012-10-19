class AlertColumnNameGradeMaster < ActiveRecord::Migration
  def change
    rename_column :user_grades, :user_grade, :grade_master_id
  end
end
