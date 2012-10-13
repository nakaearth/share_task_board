class AlertTableName < ActiveRecord::Migration
  def change
    rename_table(:tasks,:jobs)
  end

end
