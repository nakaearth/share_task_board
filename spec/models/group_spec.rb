require 'spec_helper'

describe Group do
  fixtures :users
  
  describe "group add" do
    before do
      params={name: 'testgroup', user_id: 2} 
      @group=Group.new
      @group.save_group_user params
    end
    it "save group" do
      group=Group.find_by_name('testgroup')
      group.should_not be_nil
      p group
      map=GroupMap.find_by_group_id(group.id)
      map.user_id.should eql(2)
    end 
  end 
  describe "validation check" do
    before do
      params= {user_id: 2}
      @group=Group.new
      @group.save_group_user params
    end
    it "check validate" do
      @group.should have(2).error_on(:name)
    end
  end
end
