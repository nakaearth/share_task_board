class SessionsController < ApplicationController
  def create
    auth=request.env["omniauth.auth"]
    @user=User.where("provider=?", auth["provider"]).where("uid=?", auth["uid"]).first || User.create_with_omniauth(auth)
    session[:user_id]=@user.id
    p @user
    redirect_to root_url
  end

  def destroy
    session[:user_id]=nil
    redirect_to :root ,notice: "logout success."
  end

  def failuer
    render text: "<span style='color: red;'>Auth Failure</span>"
  end
end
