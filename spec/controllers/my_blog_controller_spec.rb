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
    it "return template " do
      response.should render_template("index")
    end
  end

  context "GET 'index' new blogger " do
    before do
      @user = FactoryGirl.build(:new_blogger)
      controller.stub(:current_user) {@user}
      get 'index'
    end
    it "returns http success" do
      #response.should be_success
      #response.should render_template("index")
     response.code.should eql("302")
     response.should redirect_to action: 'new'
     #response.should render_template("new")
    end
  end

  context "Get new action" do
    before do
      @user = FactoryGirl.build(:new_blogger)
      controller.stub(:current_user) {@user}
      get 'new'
    end
    it "returns http success" do
      response.should be_success
      response.should render_template("new")
    end

  end

end
