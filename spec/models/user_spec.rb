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
      @results[0].size.should eql(2)
      @results[1].size.should eql(1)
      @results[2].size.should eql(1)
    end
  end

  context "group job list" do
    before do
      @user= User.find(1)
      @result=@user.my_group_job_list 1, 10
    end
    it "result check" do
      @result.should_not be_nil
      @result[0].size.should eql(2)
      @result[1].size.should eql(1)
    end
  end 
  
  context "report jobs " do
    before do
      @user =  User.find(1)
    end 
    it "report user job" do
      jobs_map = @user.job_report
      jobs_map.should_not be_nil
      jobs_map.size.should eql(5)
    end 
    it "report user job count test" do
      jobs_map = @user.job_report
      todo_jobs = jobs_map[:todo]
      doing_jobs = jobs_map[:doing]
      done_jobs = jobs_map[:done]

      todo_jobs.should_not be_nil
      todo_jobs.size.should eql(2)
      doing_jobs.should_not be_nil
      doing_jobs.size.should eql(1)
      done_jobs.should_not be_nil
      done_jobs.size.should eql(1)
    end
  end 

end
