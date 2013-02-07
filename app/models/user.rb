#coding: utf-8
require 'carrierwave/orm/activerecord'
require 'file_size_validator'

class User < ActiveRecord::Base

  has_many :jobs
  has_many :group_maps
  has_many :groups ,:through => :group_maps
  has_one  :blog
  mount_uploader :avatar, AvatarUploader

  validate :avatar, :file_size =>{:maximum=>0.5.megabytes.to_i }

  include User::Finder

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

  def profile_update(avatar)
    begin
      @user.avatar=avatar
      @user.save
    rescue =>e
      logger.error "profile update error"
      raise "profile update fail:"+e.message
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

  #ブログ作成
  def create_my_blog(blog_name, description)
    begin
      blog = Blog.new
      blog.name = blog_name
      blog.description = description
      blog.save
      self.blog = blog 
      self.save
    rescue  => e
      logger.error("blog create error:" + e.message)
    end
  end
end
