#coding: utf-8

class ProfileController < ApplicationController
  protect_from_forgery :except => :update_profile

  def update_profile
#    User.delay.profile_update params
    User.profile_update params
    redirect_to action: 'show', id: current_user.id, notice: 'users was successfully updated.'
  end

  def setting
    begin
      @user=User.find(current_user.id)
    rescue ActiveRecord::RecordNotFound => are
      logger.error "プロフィールデータがありません:"+are.message
      render "errors/404", layout: "errors", status: 404
    end
  end

  def show
    begin
      @user=User.find(current_user.id)
    rescue ActiveRecord::RecordNotFound => are
      logger.error "プロフィールデータがありません:"+are.message
      render "errors/404", layout: "errors", status: 404
    end 
  end
  
end
