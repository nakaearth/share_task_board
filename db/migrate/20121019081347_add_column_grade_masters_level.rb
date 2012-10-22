class AddColumnGradeMastersLevel < ActiveRecord::Migration
  def change
    add_column :grade_masters ,:level, :integer, :default=>1, :null=>false
    master= GradeMaster.where('job_count =?',1).first
    master.level=1
    master.save
    master= GradeMaster.where('job_count =?',10).first
    master.level=2
    master.save
    master= GradeMaster.where('job_count =?',30).first
    master.level=3
    master.save
    master= GradeMaster.where('job_count =?',100).first
    master.level=4
    master.save
    master= GradeMaster.where('job_count =?',200).first
    master.level=5
    master.save
    master= GradeMaster.where('job_count =?',400).first
    master.level=6
    master.save
  end

end
