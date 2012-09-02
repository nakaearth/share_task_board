#coding: utf-8

require 'spec_helper'

describe Task do
  fixtures :tasks
  fixtures :users

  context "Task receive test" do
    before do
      params={id: 1,user_id: 2}
      @result = Task.receive_task(params)

    end
    it "success case" do
      @result.should == true
    end
    it "parameter check" do
      task = Task.find(1)
      task.r_user_id.should == 2
      task.public_flag.should == 0
      task.user_id.should == 1
    end
  end
 
 # TEST
  context "task task_lists success" do
    before do
      params={user_id: 1}
      @results=Task.task_lists 1,10
    end
    it "result success value" do
      @results[0].size.should == 2 
      @results[1].size.should == 1
      @results[2].size.should == 1
    end
  end
end
