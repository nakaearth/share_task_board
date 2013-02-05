class MyBlogController < ApplicationController

  def index 
    @my_blog = current_user.my_blog

  end

  def show
    @my_blog = current_user.my_blog
  end

  def new
    @my_blog = Blog.new
  end

  def create
  end

  def edit
    @my_blog = current_user.my_blog

  end

  def update
  end

  def destroy
  end
end
