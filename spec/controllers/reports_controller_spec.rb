require 'spec_helper'

describe ReportsController do
  fixtures :users
  fixtures :jobs

  def valid_attribute
    {
      :year => '2013',
      :month => '1',
      :day => '11'
    }
  end

  describe "GET 'index'" do
    context "test user login case" do
      before do
        @user = User.find(1)
        controller.stub(:current_user) {@user}
        get :index
      end

      it "returns http success" do
        response.should be_success
      end 
    end
  end 
  describe "POST CALCULATE_JOB_COUNT" do
    context "calculate job data" do
      before do
        @user = User.find(1)
        controller.stub(:current_user) {@user}
        @params = valid_attribute
        post :calculate_job_count,{:date => @params}
      end
      it "return http success" do
        response.should be_success
      end
      it "return http value check" do
        assigns[:report_map].should_not be_nil
        assigns[:report_map].size.should eql(5)
        assigns[:report_map][:todo].should_not be_nil
        assigns[:report_map][:doing].should_not be_nil
        assigns[:report_map][:done].should_not be_nil
        assigns[:report_map][:pending].should_not be_nil
        assigns[:report_map][:finish].should_not be_nil

        assigns[:report_map][:todo].size.should eql(2)
        assigns[:report_map][:doing].size.should eql(1) 
        assigns[:report_map][:done].size.should eql(1) 
      end
    end
  end
end
