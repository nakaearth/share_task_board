class UserGrade < ActiveRecord::Base
  attr_accessible :user_grade, :user_id
  belongs_to :grade_master

  def self.set_grade(user_id)
    count=Job.where('user_id=?',user_id).where('status > ?',3).count(:id)
    @grade=GradeMaster.check_grade(count)
    @user_grade=UserGrade.where('user_id=?',user_id).first_or_create do |u_grade|
      u_grade.user_id=user_id
      u_grade.grade_master=@grade
    end
    unless @grade==@user_grade.id
      @user_grade.grade_master=@grade
      @user_grade.save
    end
    @user_grade
  end
end
