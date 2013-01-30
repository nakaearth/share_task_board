class Admin::BlogTemplateController < ApplicationController
  layout "admin_application"
  def index
    @blog_templates = BlogTemplate.all
  end

  def new 
    @blog_template = BlogTemplate.new
    @action = "create"
  end

  def create
    @blog_template = BlogTemplate.new(params[:blog_template])
    @blog_template.locale = "ja"
    @blog_template.format = "html"
    @blog_template.handler = "erb"

    respond_to do |format|
      if @blog_template.save
        format.html {redirect_to action: 'show', id: @blog_template.id, notice: 'save success.' }
      else
        format.html {render action: 'new' }
      end 
    end
  end

  def edit 
    @blog_template = BlogTemplate.find(params[:id])
    @action = "update"
  end

  def update
  end

  def destroy_template
    @blog_template = BlogTemplate.find(params[:id])
    @blog_template.destroy
  end

  def show
    @blog_template = BlogTemplate.find(params[:id])
  end
end
