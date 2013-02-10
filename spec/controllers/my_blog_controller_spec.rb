require 'spec_helper'

describe MyBlogController do
  
  context "GET 'index'" do
    before do
      @user = FactoryGirl.build(:test_blogger)
      @blog = @user.blog
      controller.stub(:current_user) {@user}
      get 'index'
    end
    it "returns http success" do
      response.should be_success
    end
  end

  context "GET 'index' new blogger " do
    before do
      @user = FactoryGirl.build(:new_blogger)
      controller.stub(:current_user) {@user}
      get 'index'
    end
    it "returns http redirect" do
      response.code.should eql("302")
    end
  end
end
