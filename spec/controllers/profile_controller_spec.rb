#coding: utf-8
#
require 'spec_helper'

describe ProfileController do
  fixtures :users

  describe "GET 'show'" do
    before do
      @user = User.find(1)
      controller.stub(:current_user) {@user}
      get 'show',id: 1
    end
    it "returns http success" do
      response.should be_success
    end
    it "template check" do
      response.should render_template("show")
    end
    it "data check" do
      assigns[:user].should_not == nil
      assigns[:user].id.should==1
    end
  end

  #セッションにデータがあるので、パラメータに何を渡しても変にならない
  describe "GET 'show' not found case" do
    before do
      @user = User.find(1)
      controller.stub(:current_user) {@user}
      get 'show',id: 1111111
    end
    it "returns http success" do
      response.should be_success
    end
    it "template check" do
      response.should render_template("show")
    end
    it "data check" do
      assigns[:user].should_not == nil
      assigns[:user].id.should==1
    end
  end

end
