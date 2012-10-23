class ApplicationController < ActionController::Base
  include Jpmobile::ViewSelector
  protect_from_forgery

  def current_grade(user_id)
    @user_grade = session['grade_'+user_id.to_s] 
    unless @user_grade
      @user_grade=UserGrade.where('user_id=?',user_id).includes(:grade_master).first
      session['grade_'+user_id.to_s]
    end
    @user_grade
  end
end
