#coding: utf-8

require 'spec_helper'

describe Blog do
  context "blog data get" do
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

  context "new blog set" do
    before do
      @user = FactoryGirl.build(:new_blogger)
    end
    it "has not blog test" do
      @user.blog.should be_nil
    end 
    it "blog save test" do
      flag = @user.create_my_blog 'test blog', 'test test test.test test.'
      flag.should be_true
      @user.blog.name.should be_eql('test blog')
    end 

  end

end
