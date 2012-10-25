class UserGrade < ActiveRecord::Base
  attr_accessible :user_grade, :user_id
  belongs_to :grade_master

  def self.set_grade(user_id)
    LevelResearchWorker.perform_async user_id
#    count=Job.where('user_id=?',user_id).where('status >= ?',3).count(:id)
#    result_map =GradeMaster.check_grade(count)
#    @grade = result_map[:grade_master]
#    next_count= result_map[:next_count]
#    UserGrade.where('user_id=?',user_id).first_or_create do |u_grade|
#      u_grade.user_id=user_id
#      u_grade.grade_master=@grade
#    end
#    @user_grade=UserGrade.where('user_id=?',user_id).first
#
#    unless @grade.level == @user_grade.grade_master.level
#      @user_grade.grade_master=@grade
#      @user_grade.save
#      @status='up'
#    else
#      @status='not_up'
#    end
#    {user_grade: @user_grade, status: @status, next_count: next_count }
  end
end
