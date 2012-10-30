require 'spec_helper'

describe UsersController do

  describe "GET 'search_user'" do
    it "returns http success" do
      get 'search_user'
      response.should be_success
    end
  end

  describe "GET 'set_user'" do
    it "returns http success" do
      get 'set_user'
      response.should be_success
    end
  end

end
