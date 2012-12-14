class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def present_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :present_user

end
