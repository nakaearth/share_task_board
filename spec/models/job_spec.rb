#coding: utf-8

require 'spec_helper'

describe Job do
  fixtures :jobs
  fixtures :users
  
  # receive test
  context "Job receive test" do
    before do
      params={id: 1,user_id: 2}
      @result = Job.receive_task params
    end
    it "success case" do
      @result.should == true
    end
    it "parameter check" do
      job = Job.find(1)
      job.r_user_id.should == 2
      job.public_flag.should == 0
      job.user_id.should == 1
    end
  end
  context "Job receive test2" do
    before do
      params={id: 1,user_id: 3}
      @result = Job.receive_task(params)
    end
    it "success case" do
      @result.should == true
    end
    it "parameter check" do
      job = Job.find(1)
      job.r_user_id.should ==3 
      job.public_flag.should == 0
      job.user_id.should == 1
    end
  end
 
 # Job List TEST
  context " task_lists success" do
    before do
      params={user_id: 1}
      @results=Job.task_lists 1,10
    end
    it "result success value" do
      @results[0].size.should == 2 
      @results[1].size.should == 1
      @results[2].size.should == 1
    end
  end

 # Job finished TEST
  context "task finished success" do
    before do
      params={user_id: 1}
      Job.finished
    end
    it "result success value" do
      @results=Job.where('status=?',4)
      @results.size.should == 2
    end
  end
  
  #job validate test
  context "job validate test" do
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
end
