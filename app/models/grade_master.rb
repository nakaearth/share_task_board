class GradeMaster < ActiveRecord::Base
  attr_accessible :job_count, :name, :level
  has_many :user_grades

  def self.check_grade(count)
    count = 1 if count==0
    @grade_master = GradeMaster.where('job_count <= ?',count).order('level DESC').first
    next_grade = GradeMaster.where('level = ?',@grade_master.level.to_i+1).first
    left_job_count = next_grade.job_count.to_i - count.to_i
    {grade_master: @grade_master, next_count: left_job_count}
  end

end
