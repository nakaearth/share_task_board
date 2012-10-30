class UsersController < ApplicationController

  def search_user
    user=User.new
    @users=user.search_user params
    @group=Group.find(params[:group_id]) 
  end

  def set_user
    #user set to group
    redirect_to action: 'show', controller: 'groups', id: params[:group_id]
  end


end
