#coding: utf-8

require 'spec_helper'

describe Task do

  context "diary save test" do
    fixtures :tasks
    before do
      params={:id=>1,:user_id=> 2}
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
end
