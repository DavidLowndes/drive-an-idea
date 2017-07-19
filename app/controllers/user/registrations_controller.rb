class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  # This is the method that automatically creates the user options for a
  # new user after they sign up. This can get funny after a db reset. What I did was comment it all out except new_user_session_path, then it threw an error for it. Then uncomment it all. Then it lets me in!
  def after_inactive_sign_up_path_for(resource)
    user = User.last
    opts = UserOption.where(user: user).first
    if opts.nil?
      opts = UserOption.new(user: user)
      opts.save
      user.user_option = opts
      user.save
    end
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:first_name, :last_name, :email, :company_id])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:first_name, :last_name, :email, :company_id])
  end
end
