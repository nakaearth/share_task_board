class Task < ActiveRecord::Base
  attr_accessible :description, :status, :title,:priority,:public_flag
  
  scope :latest, order('updated_at desc')
  scope :todo, where('status=?',1)
  scope :doing, where('status=?',2)
  scope :done, where('status=?',3)
  scope :pending, where('status=?',0)

  
  belongs_to :user
  
  def self.receive_task(params)
    task = Task.find(params[:id])
    task.r_user_id = params[:user_id]
    task.public_flag = 0
    task.save
  end
end
