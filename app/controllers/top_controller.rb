class TopController < ApplicationController
  layout "users"

  def index
    @tasks = Task.where("status=?",1).where('public_flag=?',1).latest.paginate(:per_page =>20, :page => params[:page])
  end
end
