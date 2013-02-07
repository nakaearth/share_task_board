class MyBlogController < ApplicationController

  def index 
    @my_blog = current_user.my_blog

  end

  def show
    @my_blog = current_user.my_blog
  end
  
  def template_list 
    @my_blog = current_user.my_blog
    @templte_list = blog_template.all
  end

  def set_template
    @my_blog = current_user.my_blog
    @my_blog.blog_template_id = params[:blog_template_id]
    if @my_blog.save
      redirect_to action: 'show' ,id: @my_blog.id
    else
      render :template_list
    end
  end

  def new
    @my_blog = Blog.new
  end

  def create
    @blog = Blog.new(params[:blog])
    if @blog.save
      redirect_to action: 'template_list'
    else
      render :new
    end
  end

  def edit
    @my_blog = current_user.my_blog

  end

  def update
 
  end

  def destroy
 
  end
end
