#coding: utf-8

class JobSweeper < ActionController::Caching::Sweeper
  observe Job
  
  def after_save(job)
    expire_page :action=>:index, :controller=>'top'
    expire_page :action=>:show,:id=>job.id
  end
  
  def after_destroy(job)
    expire_page :action=>:index, :controller=>'top'
    expire_page :action=>:show,:id=>job.id
  end
end
