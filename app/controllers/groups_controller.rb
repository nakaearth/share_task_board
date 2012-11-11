class GroupsController < ApplicationController

  def index
    @groups=Group.paginate(:page=>params[:page], :per_page=>20)
    #Groupは5件まで
    @groups=User.find(current_user.id).groups.limit(5)
  end

  def show
    @group=Group.find(params[:id])
    @group_users=@group.users
    @count=GroupMap.where('group_id=?',params[:id]).count(:user_id)
  end

  def new
    @group=Group.new
  end

  def create
    @group=Group.new(params[:group])
    respond_to do |format| 
      if @group.save
        @user=User.find(current_user.id)
        @groups=@user.groups
        @groups << @group
        @user.save
        format.html {redirect_to @group, :notice =>'save success.'}
      else
        format.html {render new}
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
