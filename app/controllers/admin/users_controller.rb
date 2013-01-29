class Admin::UsersController < ApplicationController
  layout "admin_application"

  def index
    @users = User.paginate(per_page: 20, page: params[:page])
  end
end
