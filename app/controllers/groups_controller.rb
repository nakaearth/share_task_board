class GroupsController < ApplicationController
  def index
    @groups=Group.paginate(:page=>params[:page], :per_page=>20)
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
