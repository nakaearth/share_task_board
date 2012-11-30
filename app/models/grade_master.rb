class GradeMaster < ActiveRecord::Base
  attr_accessible :job_count, :name, :level
  has_many :user_grades

  def self.check_grade(count)
    begin
      count = 0 if count < 0 || count==nil
      @grade_master = GradeMaster.where('job_count <= ?',count).order('level DESC').first
      if @grade_master
        level = @grade_master.level.to_i+1
      else
        level=1
        @grade_master=GradeMaster.where('level =?',1).first
      end
      next_grade = GradeMaster.where('level = ?',level).first
      @left_job_count = next_grade.job_count.to_i - count.to_i
      {grade_master: @grade_master, next_count: @left_job_count}
    rescue => e
      raise "ERROR:#{e.message}"
    end
  end

end
