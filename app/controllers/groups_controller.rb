class GroupsController < ApplicationController

  def index
    @groups=Group.paginate(:page=>params[:page], :per_page=>20)
    @groups=User.find(current_user.id).groups.paginate(:page=>params[:page], :per_page=>20)
  end

  def show
    @group=Group.find(params[:id])
    @group_users=@group.users
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
