#coding: utf-8

require 'spec_helper'

describe BlogTemplate do
  describe "blog_template get" do
    before do
      @user = FactoryGirl.build(:test_blogger)
      @blog_template = @user.blog_template
    end 
    it "nil check" do
      @user.name.should_not be_nil
      @blog_template.should_not be_nil 
    end 
    it "value check" do
      @blog_template.body.should_not be_nil
      p @blog_template.body
    end
  end
end
