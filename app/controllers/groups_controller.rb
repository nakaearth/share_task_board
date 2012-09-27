class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @groups=Group.paginate(:page=>params[:page], :per_page=>20)
    @groups=User.find(current_user.id).groups.paginate(:page=>params[:page], :per_page=>20)
  end

  def show
  end

  def new
    @group=Group.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
