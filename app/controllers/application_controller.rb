#coding: utf-8

class ApplicationController < ActionController::Base
  include Jpmobile::ViewSelector
  protect_from_forgery

  helper_method :current_user
  before_filter :reset_session_expires

  rescue_from RuntimeError, :with => :runtime_error
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActionController::RoutingError, :with => :routing_error
  rescue_from JobError, :with => :job_error


  def current_grade(user_id)
    @user_grade = session['grade_'+user_id.to_s] 
    unless @user_grade
      @user_grade=UserGrade.where('user_id=?',user_id).includes(:grade_master).first
      session['grade_'+user_id.to_s]
    end
    @user_grade
  end
 
  #Error views
  def job_error
    logger.error("ERROR: Job error.")
    render "error/job_error",layout: "error", status: 500
  end

  def record_not_found
    logger.error("ERROR: Record not found.")
    render "error/404", layout: "error", status: 404
  end

  def routing_error
    logger.error("ERROR: Routing error. This url is Invalid.")
    render "error/404",layout: "error", status: 404
  end

  def runtime_error
    logger.error("Runtime error.")
    render "error/500",layout: "error", status: 500
  end
 

  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end
  
  def current_user
    begin
      @current_user ||=User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound=>e
      @current_user,session[:user_id]=null 
    end
  end 

  if Rails.env.test?
    prepend_before_filter :stub_current_user
    def stub_current_user
      @test_user = FactoryGirl.create(:current_user)
      session[:user_id] = @test_user.id
    end
  end
end
