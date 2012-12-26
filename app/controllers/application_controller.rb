class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_fb_user, :current_twitter_user

  private

  def current_fb_user
    #unless @current_user.provider == "facebook"
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
     # end
  end

  def current_twitter_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      #return false unless @current_user.provider == "twitter"
  end

end
