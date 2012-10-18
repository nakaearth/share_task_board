class CreateGradeMasters < ActiveRecord::Migration
  def change
    create_table :grade_masters do |t|
      t.string :name,:null=>false, :length=>30
      t.integer :job_count,:null=>false ,:default=>0

      t.timestamps
    end
  end
end
