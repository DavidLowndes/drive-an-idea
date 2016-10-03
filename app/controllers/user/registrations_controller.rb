class User::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  #after_create :build_user_options
  
  def after_sign_up_path_for(resource)
      build_user_options
      request.env['omniauth.origin'] || stored_location_for(resource) || root_path
      
  end
  
  private
  
  def build_user_options
    opts = UserOption.new(user: current_user)
    current_user.user_option = opts
    current_user.save
    opts.save
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:first_name, :last_name, :email])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:first_name, :last_name, :email])
  end
end
