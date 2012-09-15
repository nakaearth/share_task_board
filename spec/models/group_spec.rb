require 'spec_helper'

describe Group do
  fixtures :users
  
  context "group add" do
    before do
      params={name: 'testgroup', user_id: 2} 
      @group=Group.new
      @group.save_group_user params
    end
    it "save group" do
      group=Group.find_by_name('testgroup')
      group.should_not==nil
      p group
      map=GroupMap.find_by_group_id(group.id)
      map.user_id.should==2
    end 
  end 
end
