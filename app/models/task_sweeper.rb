#coding: utf-8

class TaskSweeper < ActionController::Caching::Sweeper
  observe Task
  
  def after_save(task)
    expire_page :action=>:index, :controller=>'top'
    expire_page :action=>:show,:id=>task.id
  end
  
  def after_destroy(task)
    expire_page :action=>:index, :controller=>'top'
    expire_page :action=>:show,:id=>task.id
  end
end
