class UserOptionsController < ApplicationController
  def edit
    @user_options = current_user.user_option
  end
  
  def update
    
  end
end