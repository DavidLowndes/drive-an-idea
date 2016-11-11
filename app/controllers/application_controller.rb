# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Changed to before action as filter will be removed in rails 5.1
  before_action :authenticate_user!
  before_action :set_search

  rescue_from CanCan::AccessDenied do
    redirect_back(fallback_location: root_path)
    flash[:danger] = 'You are not authorised to access that page'
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || my_area_path
  end

  def set_search
    @search = Idea.search(params[:q])
  end
end
