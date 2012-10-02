require 'spec_helper'

describe UsersController do

  describe "GET 'setting'" do
    it "returns http success" do
      get 'setting'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
