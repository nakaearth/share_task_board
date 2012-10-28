class Admin::JobsController < Admin::ApplicationController
  layout "admin_application"

  def index
    @jobs=Job.paginate(page: params[:page], per_page: '20')
  end

  def show
    @job=Job.find(params[:id])
  end

  def edit
    @job=Job.find(params[:id])
  end

  def update
  end
end
