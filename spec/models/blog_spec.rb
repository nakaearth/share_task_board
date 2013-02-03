#coding: utf-8

require 'spec_helper'

describe Blog do
  describe "blog get" do
    before do
      @user = FactoryGirl.build(:test_blogger)
      @blog = @user.blog
    end 
    it "nil check" do
      @blog.should_not be_nil
    end 
    it "value check" do
      @blog.name.should_not be_nil
      @blog.blog_template.body.should_not be_nil
    end
  end
end
