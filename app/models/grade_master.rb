class GradeMaster < ActiveRecord::Base
  attr_accessible :job_count, :name
  has_many :user_grades

  def self.check_grade(count)
    @grade_master = GradeMaster.where('job_count <= ?',count).order('job_count DESC').first
    @grade_master
  end

end
