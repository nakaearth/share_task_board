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
    @user=User.find(params[:id])
    @user.avatar=params[:avatar]
    @user.save
  end

  def search_user(params)
    user_id_array=GroupMap.where('group_id=?',params[:group_id]).pluck(:user_id)
    user_list=user_id_array.join(',')
    @users=User.where('provider =?',params[:provider])
               .where('name like ?',"#{params[:name]}%")
               .where(['id not in(?)',user_id_array])
               .paginate(:page=>params[:page], :per_page=>params[:per_page]) 
  end
end
