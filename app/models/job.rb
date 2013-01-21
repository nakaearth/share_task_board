#coding: utf-8

class Job < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  #elastic search
  include Tire::Model::Search
  include Tire::Model::Callbacks

  ## finder methods
  include Job::Finder 

  scope :latest,-> {order('updated_at desc') }
  scope :todo, ->{where('status=?',1) }
  scope :doing,-> {where('status=?',2) }
  scope :done, -> {where('status=?',3) }
  scope :finish,-> {where('status=?',4) }
  scope :pending,-> {where('status=?',0)}
  
  belongs_to :user
  belongs_to :group

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
   
   
  def self.receive_job(params)
    begin
      transaction do
        @job=Job.find(params[:id])
        @job.r_user_id = params[:user_id]
        @job.public_flag = 0
        @job.save!
      end
    rescue ActiveRecord::RecordNotFound
      raise JobError, "ジョブ情報がありません"
    end
  end

  def update_job(update_attr)
    begin
      transaction do
        if status=='3'
          UserGrade.set_grade self.user.id
          #Mailer deliver
          NotifyMailer.notify_mail(self.user).deliver
        end
        return self.update_attributes(update_attr)
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
  
end
