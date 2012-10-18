class GradeMaster < ActiveRecord::Base
  attr_accessible :job_count, :name
  has_many :user_grades
end
