class SessionsController < ApplicationController
  def new
    redirect_to '/auth/'+ (Rails.env.production? ? 'twitter': 'developer')
  end

  def create
    auth=request.env["omniauth.auth"]
    @user=User.where("provider=?", auth["provider"]).where("uid=?", auth["uid"]).first || User.create_with_omniauth(auth)
    session[:user_id]=@user.id
    p @user
    redirect_to :root ,notice: "login success."
  end

  def destroy
    session[:user_id]=nil
    redirect_to :root ,notice: "logout success."
  end

  def failuer
    render text: "<span style='color: red;'>Auth Failure</span>"
  end

  def back_to
    if request.env['omniauth.origin'].presence && back_to = CGI.unescape(request.env['omniauth.origin'].to_s)
      uri = URI.parse(back_to)
      return back_to if uri.relative? || uri.host == request.host
    end
    nil
  rescue
    nil
  end
end
