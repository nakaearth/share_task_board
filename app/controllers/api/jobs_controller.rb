class Api::JobsController < ApplicationController
  def my_list
    user = User.find(params[:user_id])
    @jobs = user.my_job_list(10)
    render :json=>@jobs
  end

  def save
  end

  def update
  end

  def delete
  end

  def show
  end
end
