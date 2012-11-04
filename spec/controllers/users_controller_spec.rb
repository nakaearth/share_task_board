require 'spec_helper'

describe UsersController do
  fixtures :users
  describe "omniauth login test" do
    before do
      @user = User.find(1)
      controller.stub(:current_user) {@user} 
    end 
    it "login user check" do
       @user.name.should == "test name"
    end
  end

#  describe "GET 'search_user'" do
#    it "returns http success" do
#      get 'search_user'
#      response.should be_success
#    end
#  end

#  describe "GET 'set_user'" do
#    it "returns http success" do
#      get 'set_user'
#      response.should be_success
#    end
#  end

end
