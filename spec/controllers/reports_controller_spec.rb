require 'spec_helper'

describe ReportsController do
  fixtures :users
  fixtures :jobs

  describe "GET 'index'" do
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
