
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def update 
    Cloudinary::Uploader.upload(params[:avatar])
    @user=User.find(current_user.id)
    @user.avatar=params[:avatar]
    @user.save
    redirect_to action: 'show', id: @user.id, notice: 'users was successfully updated.'
  end

  def setting
    @user=User.find(current_user.id)
  end

  def show
    @user=User.find(current_user.id)
  end
end
