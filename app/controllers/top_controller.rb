class TopController < ApplicationController
#  caches_page :index

  def index
    @jobs = Job.where("status=?",1).where('public_flag=?',1).where('r_user_id=?',0).latest.paginate(:per_page =>20, :page => params[:page])
  end
end
