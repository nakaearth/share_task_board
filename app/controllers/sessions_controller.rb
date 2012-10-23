class SessionsController < ApplicationController
  def callback
    auth=request.env["omniauth.auth"]
    @user=User.where(provider: auth["provider"],uid: auth["uid"]).first || User.create_with_omniauth(auth)
    session[:user_id]=@user.id
    redirect_to action: 'index', controller: 'top', notice: "login success."
  end

  def destroy
    session[:user_id]=nil
    redirect_to :root ,notice: "logout success."
  end

  def failuer
    render text: "<span style='color: red;'>Auth Failure</span>"
  end
end
