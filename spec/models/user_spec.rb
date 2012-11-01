require 'spec_helper'

describe User do
  
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
end
