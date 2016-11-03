class User::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  # This is the method that automatically creates the user options for a
  # user after the sign up for the first time
  def after_sign_up_path_for(resource)
    # Create options
    build_user_options
    # This line means 'redirect to where you'd usually go after you sign up'
    request.env['omniauth.origin'] || stored_location_for(resource) || my_area_path
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

