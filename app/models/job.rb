class Job < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks
#  index_name BONSAI_INDEX_NAME
  attr_accessible :description, :status, :title,:priority,:public_flag
  
  scope :latest, order('updated_at desc')
  scope :todo, where('status=?',1)
  scope :doing, where('status=?',2)
  scope :done, where('status=?',3)
  scope :finish, where('status=?',4)
  scope :pending, where('status=?',0)
  
  belongs_to :user

  validates :title ,:presence=>true ,:length=>{:within=>5..80}
  validates :description ,:presence=>true ,:length=>{:within=>1..270}
 
  def self.task_lists(user_id, per_count)
    @todo_tasks=Job.todo.where('user_id=?',user_id).latest.limit(per_count)
    @doing_tasks=Job.doing.where('user_id=?',user_id).latest.limit(per_count)
    @done_tasks=Job.done.where('user_id=?',user_id).latest.limit(per_count)
    [@todo_tasks, @doing_tasks, @done_tasks]
  end
   
  def self.receive_task_lists(user_id, per_count)
    @todo_tasks=Job.todo.where('r_user_id=?',user_id).latest.limit(per_count)
    @doing_tasks=Job.doing.where('r_user_id=?',user_id).latest.limit(per_count)
    @done_tasks=Job.done.where('r_user_id=?',user_id).latest.limit(per_count)
    [@todo_tasks, @doing_tasks, @done_tasks]
  end
   
  def self.receive_task(params)
    @job=Job.find(params[:id])
    @job.r_user_id = params[:user_id]
    @job.public_flag = 0
    @job.save!
  end
  
  def self.finished
    transaction do
      self.update_all ['status=?',4],['status=?',3]
    end
  end
  
  def self.group_task_list(params)
    @tasks=Job.where('group_id=?',params[:group_id])    
  end
end
