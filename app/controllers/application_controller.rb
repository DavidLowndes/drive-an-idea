# Application Controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_search # Changed to before action as filter will be removed in rails 5.1

  rescue_from CanCan::AccessDenied do
    redirect_to :back
    flash[:danger] = 'You are not authorised to access that page'
  end

  def set_search
    @search = Idea.search(params[:q])
  end
end
