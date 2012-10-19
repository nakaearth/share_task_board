#coding: utf-8

class AddMasterData < ActiveRecord::Migration
  def change
    @master=GradeMaster.new
    @master.name='初級者'
    @master.job_count=1
    @master.save

    @master2=GradeMaster.new
    @master2.name='作業者'
    @master2.job_count=10
    @master2.save

    @master3=GradeMaster.new
    @master3.name='job兵士'
    @master3.job_count=30
    @master3.save
 
    @master4=GradeMaster.new
    @master4.name='job導師'
    @master4.job_count=100
    @master4.save
 
    @master5=GradeMaster.new
    @master5.name='job戦士'
    @master5.job_count=200
    @master5.save

    @master6=GradeMaster.new
    @master6.name='job将軍'
    @master6.job_count=400
    @master6.save
  end

end
