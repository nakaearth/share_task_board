class Admin::ApplicationController < ActionController::Base
  
  if Rails.env.production?
    http_basic_authenticate_with realm: "sharetaskboard", name: "admin", password: "sharetaskboard"
  end
end
