class UsersController < ApplicationController

  def update 
    @user=User.find(current_user.id)
    #@user.avatar=params[:avatar]
    @user.avatar=File.open(params[:avatar])
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
