class UsersController < ApplicationController

  def search_user
    @group=Group.find(params[:group_id])
    user=User.new
    @users=user.search_user params
  end

  def set_user
    #user set to group
    group=Group.find(params[:group_id])
    @user=User.find(params[:user_id])
    @user.groups << group
    if @user.save
      redirect_to action: 'show', controller: 'groups', id: params[:group_id]
    else
      render action: 'show', controller: 'groups', id: params[:group_id]
    end
  end


end
