# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do
    redirect_to :back
    flash[:danger] = 'You are not authorised to access that page'
  end
end
