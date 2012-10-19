class GradeMaster < ActiveRecord::Base
  attr_accessible :job_count, :name, :level
  has_many :user_grades

  def self.check_grade(count)
    count = 1 if count==0
    @grade_master = GradeMaster.where('job_count <= ?',count).order('level DESC').first
    @grade_master
  end

end
