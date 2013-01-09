require 'spec_helper'

describe JobsController do
  def valid_session
    {
      :title=>'test job',
      :description=>'test test test',
      :status=>'1',
      :priority=>'1',
      :group_id=>'1',
      :public_flag=>'0',
      :r_user_id=>'0'   
    }
  end
  
  def valid_attribute
    {
      :title=>'test job',
      :description=>'test test test',
      :status=>'1',
      :priority=>'1',
      :group_id=>'1',
      :public_flag=>'0',
      :r_user_id=>'0'
    }
  end

  def error_attribute
    {
      :title=>'test',
      :description=>'test test test',
      :status=>'1',
      :priority=>'1',
      :group_id=>'1',
      :public_flag=>'0',
      :r_user_id=>'0'
    }
  end

  describe "GET index" do
    fixtures :users
    fixtures :jobs
    fixtures :groups

    before do
      @user = User.find(1)
      controller.stub(:current_user) {@user}
      get :index 
    end
    it "login user check" do
       @user.name.should == "test name"
    end
    it "response code check" do
      response.should be_success
    end
    it "response render test" do
      response.should render_template("index")
    end
    it "job_list" do
      assigns(:todo_jobs).should_not be_nil
      assigns(:todo_jobs).size.should eql(2)
      assigns(:doing_jobs).should_not be_nil
      assigns(:doing_jobs).size.should eql(1)
      assigns(:done_jobs).should_not be_nil
      assigns(:done_jobs).size.should eql(1)
    end
  end
  describe "GET group job list" do
    fixtures :users
    fixtures :jobs
    fixtures :groups

    before do
      @user = User.find(1)
      controller.stub(:current_user) {@user}
      get :my_group_job_list,group_id: 1 
    end
    it "login user check" do
       @user.name.should eql("test name")
    end
    it "response code check" do
      response.should be_success
    end
    it "response render test" do
      response.should render_template("my_group_job_list")
    end
    it "job_list" do
      assigns(:todo_jobs).should_not be_nil
      assigns(:todo_jobs).size.should eql(2)
      assigns(:doing_jobs).should_not be_nil
      assigns(:doing_jobs).size.should eql(1)
      assigns(:done_jobs).should_not be_nil
      assigns(:done_jobs).size.should eql(0)
    end
  end

  describe "new job save" do
    fixtures :users
    fixtures :jobs
    fixtures :groups

    describe "with valid params" do
      before do
        @user = User.find(1)
        controller.stub(:current_user) {@user}
      end
      it "assigns a newly created task as @job" do
        post :create,{:job=> valid_attribute}
        assigns(:job).should be_a(Job)
        assigns(:job).should be_persisted
      end
      it "redirects to the created job" do
        post :create, {:job => valid_attribute}, valid_session
        response.should redirect_to(Job.last)
      end
    end
  end
  describe "new job create error" do
    fixtures :users
    fixtures :jobs
    fixtures :groups

    describe "with valid params" do
      before do
        @user = User.find(1)
        controller.stub(:current_user) {@user}
      end
      it "assigns a newly created task as @job" do
        post :create,{:job=> error_attribute}
        assigns(:job).should be_a(Job)
        assigns(:job).should have(1).error_on(:title)
      end
      it "redirects to the created job" do
        @params=valid_attribute
        @params[:title]="test job"
        @params[:description] =""

        post :create, {:job => @params}
        assigns(:job).should have(2).error_on(:description)
      end
      it "redirects to the created job" do
        @params=valid_attribute
        @params[:title] = ""
        @params[:description] = ""

        post :create, {:job => @params}
        assigns(:job).should have(2).error_on(:title)
        assigns(:job).should have(2).error_on(:description)
      end
    end
  end

#  describe "job list test" do
#    fixtures :users
#    fixtures :jobs
#    fixtures :groups
#
#    before do
#      @user = User.find(1)
#      controller.stub(:current_user) {@user}
#      @user.stub(:my_job_list).and_raise(RuntimeError)
#    end
#    it "login user check" do
#      #lambda{get :index  }.should raise_error(RuntimeError)
#    end
#  end

  describe "job receive_job" do
    fixtures :users
    fixtures :jobs
    fixtures :groups
    fixtures :user_grades
    fixtures :grade_masters
    
    before do
      @user=User.find(1)
      @job=Job.where('user_id=?',2).first
      controller.stub(:current_user) {@user}
      get :receive_task, {:id => @job.id,:user_id =>@user.id}
    end 
    it "receive_job success case" do
      response.code.should eql("302")
    end

  end

end
