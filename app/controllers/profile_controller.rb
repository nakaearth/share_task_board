class ProfileController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => :update_profile

  def update_profile
    @user=User.find(params[:id])
    @user.avatar=params[:avatar]
    p @user
    @user.save
    Cloudinary::Uploader.upload(params[:avatar],:public_id=>@user.id,
                                :eager => [{:width =>480 , :height => 480, 
                                :crop => :fill, :format => 'png',:gravity => :face}])
    redirect_to action: 'show', id: @user.id, notice: 'users was successfully updated.'
  end

  def setting
    @user=User.find(current_user.id)
  end

  def show
    @user=User.find(current_user.id)
  end

end
