class UserGrade < ActiveRecord::Base
  attr_accessible :user_grade, :user_id
  belongs_to :user_grade 
end
