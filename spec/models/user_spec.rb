require 'spec_helper'

describe User do
  fixtures :jobs
  fixtures :users
  fixtures :groups

  context "user save test" do
    before do
      auth={"provider"=> 'twitter',"uid"=> 'aaaabbbcc1222'}
      @user=User.create_with_omniauth(auth)
    end
    it "save user_id " do
      @user.should_not == nil
    end
    it "test attribute check" do
      @user.provider.should == 'twitter'
    end
  end

  # Job List TEST
  context " task_list success" do
    before do
      @user=User.find(1)
      @results=@user.my_job_list 10
    end
    it "result success value" do
      @results[0].size.should == 2
      @results[1].size.should == 1
      @results[2].size.should == 1
    end
  end

  context "group job list" do
    before do
      @user= User.find(1)
      @result=@user.my_group_job_list 1, 10
    end
    it "result check" do
      @result.should_not be_nil
      @result[0].size.should == 2
      @result[1].size.should == 1
    end
  end 
  
  context "report jobs " do
    before do
      @user =  User.find(1)
    end 
    it "report user job" do
      jobs = @user.job_report
      jobs.should_not be_nil
    end
  end 

end
