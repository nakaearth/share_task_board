class UserGrade < ActiveRecord::Base
  attr_accessible :user_grade, :user_id
  belongs_to :grade_master

  def self.set_grade(user_id)
    LevelResearchWorker.perform_async user_id
  end
end
