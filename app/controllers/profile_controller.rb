class ProfileController < ApplicationController
  protect_from_forgery :except => :update_profile

  def update_profile
    #User.delay.profile_update params
    User.profile_update params
    redirect_to action: 'show', id: current_user.id, notice: 'users was successfully updated.'
  end

  def setting
    @user=User.find(current_user.id)
  end

  def show
    @user=User.find(current_user.id)
  end
  
end
