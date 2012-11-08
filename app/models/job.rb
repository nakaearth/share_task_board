#coding: utf-8

class Job < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  #elastic search
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  scope :latest,-> {order('updated_at desc') }
  scope :todo, ->{where('status=?',1) }
  scope :doing,-> {where('status=?',2) }
  scope :done, -> {where('status=?',3) }
  scope :finish,-> {where('status=?',4) }
  scope :pending,-> {where('status=?',0)}
  
  belongs_to :user

  validates :title ,:presence=>true ,:length=>{:within=>5..80}
  validates :description ,:presence=>true ,:length=>{:within=>1..270}
  validates :priority ,:presence=>true ,:numericality=>{:only_integer=>true,:less_than_or_equal_to=>3}
  validates :status ,:presence=>true ,:numericality=>{:only_integer=>true,:less_than_or_equal_to=>4}
  validates :public_flag ,:presence=>true ,:numericality=>{:only_integer=>true,:less_than_or_equal_to=>1}

  #Elastic search
  tire do
    mapping do
      indexes :title, :analyzer => 'snowball', :boost => 100 
    end 
  end
 
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
    transaction do
      @job=Job.find(params[:id])
      @job.r_user_id = params[:user_id]
      @job.public_flag = 0
      @job.save!
    end
  end

  def update_job(title,description,status,priority,public_flag)
    begin
      Job.transaction do
        if status=='3'
          UserGrade.set_grade self.user.id
          #Mailer deliver
          NotifyMailer.notify_mail(self.user).deliver
        end
        return self.update_attributes(:title=> title, :description=> description,
                                      :status=> status, :priority=>priority, :public_flag=> public_flag)
      end
    resuce ActiveRecord::StaleObjectError
      return false
    end
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
