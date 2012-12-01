#coding: utf-8
require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base

  # attr_accessible :provider, :uid
  has_many :jobs
  has_many :group_maps
  has_many :groups ,:through => :group_maps
  mount_uploader :avatar, AvatarUploader

  def self.create_with_omniauth(auth)
    @user=User.new
    @user.provider=auth["provider"]
    @user.uid=auth["uid"]
    unless auth["info"].blank?
      @user.name=auth["info"]["name"]
      @user.screen_name=auth["info"]["nickname"]
      @user.image=auth["info"]["image"]
    end 
    @user.save!
    @user 
  end

  def self.profile_update(params)
    begin
      @user=User.find(params[:id])
      @user.avatar=params[:avatar]
      @user.save
    rescue
      raise "profile update fail."
    end
  end

  def search_user(params)
    begin
      user_id_array=GroupMap.where('group_id=?',params[:group_id]).pluck(:user_id)
      user_list=user_id_array.join(',')
      @users=User.where('provider =?',params[:provider])
                 .where('name like ?',"#{params[:name]}%")
                 .where(['id not in(?)',user_id_array])
                 .paginate(:page=>params[:page], :per_page=>params[:per_page]) 
    rescue 
      logger.error("検索処理でエラーが発生しました")
      @users=Array.new
    end
  end

  #グループ関連
  def my_groups
    @groups=self.groups
  end

  #JOB関連
  def my_job_list(per_count)
    begin
      @todo_jobs=self.jobs.todo.latest.limit(per_count)
      @doing_jobs=self.jobs.doing.latest.limit(per_count)
      @done_jobs=self.jobs.done.latest.limit(per_count)
      [@todo_jobs, @doing_jobs, @done_jobs]
    rescue ActiveRecord::RecordNotFound 
      logger.error("My job data not found.")
      []
    rescue RuntimeError => e
      logger.error("application error!:"+e.message)
      []
    end
  end

  def my_receive_job_list(per_count)
    begin
      @todo_jobs=Job.todo.where('r_user_id=?',self.id).latest.limit(per_count)
      @doing_jobs=Job.doing.where('r_user_id=?',self.id).latest.limit(per_count)
      @done_jobs=Job.done.where('r_user_id=?',self.id).latest.limit(per_count)
      [@todo_jobs, @doing_jobs, @done_jobs]
    rescue ActiveRecord::RecordNotFound 
      logger.error("My recevie job data not found.")
      []
    rescue RuntimeError => e
      logger.error("application error!:"+e.message)
      []
    end
  end

  def my_group_job_list(group_id, per_count)
    begin
      @todo_jobs=self.jobs.todo.where('group_id=?',group_id).latest.limit(per_count)
      @doing_jobs=self.jobs.doing.where('group_id=?',group_id).latest.limit(per_count)
      @done_jobs=self.jobs.done.where('group_id=?',group_id).latest.limit(per_count)
      [@todo_jobs, @doing_jobs, @done_jobs]
    rescue ActiveRecord::RecordNotFound 
      logger.error("My group job data not found.")
      []
    rescue RuntimeError => e
      logger.error("application error!:"+e.message)
      []
    end
  end
end
