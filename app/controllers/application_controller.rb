class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_fb_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_fb_user

end
