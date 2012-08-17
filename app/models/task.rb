class Task < ActiveRecord::Base
  attr_accessible :description, :status, :title,:priority,:public_flag
  
  scope :latest, order('updated_at desc')
  
  belongs_to :user
  
  def self.receive_task(params)
    task = Task.find(params[:id])
    task.user_id = params[:user_id]
    task.public_flag = 0
    task.save
  end
end
