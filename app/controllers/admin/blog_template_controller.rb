class Admin::BlogTemplateController < ApplicationController
  layout "admin_application"
  def index
    @templates = BlogTemplate.all
  end

  def new 
    @blog_template = BlogTemplate.new
  end

  def create
  end

  def edit 
    @blog_template = BlogTemplate.find(params[:id])
  end

  def update
  end

  def destroy
    @blog_template = BlogTemplate.find(params[:id])
  end

  def show
    @blog_template = BlogTemplate.find(params[:id])
  end
end
