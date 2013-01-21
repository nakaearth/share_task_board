#coding: utf-8

require 'spec_helper'

describe Job do
  fixtures :jobs
  fixtures :users
  
  #receive_job_list
  describe "receive_job_list test" do
    before do
      @jobs=Job.receive_job_list(2, 10)
    end
    it "check job" do
      @jobs.should_not be_nil
    end
    it "check return value size " do
      @jobs.size.should==3
      @jobs[0].size.should eql(0)
      @jobs[1].size.should eql(1)
      @jobs[2].size.should eql(1)
    end
  end
  describe "receive_job_list error test" do
    before do
      @jobs=Job.receive_job_list(4, 10)
    end
    it "check job" do
      @jobs.should_not be_nil
    end
    it "check return value size " do
      @jobs.size.should eql(3)
      @jobs[0].size.should eql(0)
      @jobs[1].size.should eql(0)
    end
  end

  # receive test
  describe "Job receive test" do
    before do
      params={id: 1,user_id: 2}
      @result = Job.receive_job params
    end
    it "success case" do
      @result.should be_true
    end
    it "parameter check" do
      job = Job.find(1)
      job.r_user_id.should eql(2)
      job.public_flag.should eql(0)
      job.user_id.should eql(1)
    end
  end
  describe "Job receive test2" do
    before do
      params={id: 1,user_id: 3}
      @result = Job.receive_job(params)
    end
    it "success case" do
      @result.should be_true
    end
    it "parameter check" do
      job = Job.find(1)
      job.r_user_id.should eql(3) 
      job.public_flag.should eql(0)
      job.user_id.should  eql(1)
    end
  end
  describe "job receive_task exception test" do
    before do
    end
    it "error check" do
      params={id: 100,user_id: 3}
      lambda{Job.receive_job(params)}.should raise_error(JobError)
    end
    it "error check 2" do
      params={id: 1011,user_id: 'hogehoge'}
      lambda{Job.receive_job(params)}.should raise_error(JobError)
    end
  end

 # Job finished TEST
  describe "task finished success" do
    before do
      params={user_id: 1}
      Job.finished
    end
    it "result success value" do
      @results=Job.where('status=?',4)
      @results.size.should eql(6)
    end
  end
  
  #job validate test
  describe "job validate test" do
    before do
      @job=jobs(:valid)
    end
    it "validate title test" do
      @job.title =""
      @job.should_not be_valid
    end
    it "validate description test" do
      @job.description=""
      @job.should_not be_valid
    end 
    it "validate status test" do
      @job.status="5"
      @job.should_not be_valid
    end 
    it "validate priority test" do
      @job.priority="5"
      @job.should_not be_valid
    end 
    it "validate public_flag test" do
      @job.public_flag="3"
      @job.should_not be_valid
    end 
  end
  
  describe "job attribute update" do
    before do
      params={'id'=>1,'title'=>'test job', 'description'=>'test test test', 'status'=>'2', 'priority'=>'2', 'public_flag'=>'0'}
      @job=Job.find(1)
      @job.update_job params
    end
    it "update test" do
      @job.title.should eql('test job')
      @job.status.should eql(2)
      @job.priority.should eql(2)
    end
  end

  describe "group job test" do
    fixtures :groups
    before do
      @group=Group.find(1)
      @jobs=Job.group_all_jobs 1,8
    end
    it "jobs test" do
      @jobs.should_not be_nil
      @jobs.size.should eql(3)
      @jobs[0].size.should eql(3)
      @jobs[1].size.should eql(2)
      @jobs[2].size.should eql(1)
    end
  end 

  describe "" do
    before do
      @jobs = Job.job_list(20)
    end 
    it "job list finder test" do
      @jobs.should_not be_nil
      @jobs.size.should eql(3)
    end
    it "job list finder value check" do
      @jobs[0].size.should eql(3)
      @jobs[1].size.should eql(2)
      @jobs[2].size.should eql(5)

    end
  end

end
