#coding: utf-8

class ProfileController < ApplicationController
  protect_from_forgery :except => :update_profile

  def update_profile
    begin
      User.profile_update params
      redirect_to action: 'show', id: current_user.id, notice: 'users was successfully updated.'
    rescue => e
      logger.error "profile update error:"+e.message
      @error= "profile update error:"+e.message
      render "error/500", layout: "error", status: 500
    end
  end

  def setting
    begin
      @user=User.find(current_user.id)
    rescue ActiveRecord::RecordNotFound => are
      logger.error "プロフィールデータがありません:"+are.message
      render "error/404", layout: "error", status: 404
    end
  end

  def show
    begin
      @user=User.find(current_user.id)
    rescue ActiveRecord::RecordNotFound => are
      logger.error "プロフィールデータがありません:"+are.message
      render "error/404", layout: "error", status: 404
    end 
  end
  
end
