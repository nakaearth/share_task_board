class NotifyMailer < ActionMailer::Base
  default from: "sharetaskboard@freeml.com"
  def notify_mail(user)
    @user=user
    @url="http://sharetaskboard.herokuapp.com/"
    mail(:to=>"rails3sample@yahoo.co.jp", 
         :subject=>"login share taskboard")
  end
end
