class ApplicationController < ActionController::Base
  include Jpmobile::ViewSelector
  protect_from_forgery

  helper_method :current_user
  before_filter :reset_session_expires

  def current_grade(user_id)
    @user_grade = session['grade_'+user_id.to_s] 
    unless @user_grade
      @user_grade=UserGrade.where('user_id=?',user_id).includes(:grade_master).first
      session['grade_'+user_id.to_s]
    end
    @user_grade
  end
  
  private
  
  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end
  
  def current_user
    @current_user ||=User.where(id: session[:user_id]).first
  end
end
