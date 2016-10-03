class UserOptionsController < ApplicationController
  def edit
    @user_options = current_user.user_option
  end
  
  def update
    @user_options = current_user.user_option
    respond_to do |format|
      if @user_options.update(user_options_params)
        format.html {
          redirect_to ideas_path, notice: 'User options successfully updated!'
        }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit }
        format.json { render json: @user_options.errors, status: :unprocessable_entity }
      end
    end
    
  end
  
  private
  
  def user_options_params
    params.require(:user_option).permit(:anonymous_comments_default,
                                         :real_time_voting_default,
                                         :reveal_voter_details_default)
  end
  
end