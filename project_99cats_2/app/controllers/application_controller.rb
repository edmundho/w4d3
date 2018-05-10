class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  
  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def login(user)
    if session[:session_token]
      session[:session_token] = user.session_token
    else
      session[:session_token] = user.reset_session_token!
    end
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_login
    redirect_to cats_url if logged_in?
  end
end
