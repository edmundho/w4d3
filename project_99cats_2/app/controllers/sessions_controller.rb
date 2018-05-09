class SessionsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login(@user)
      redirect_to cats_url
    else
      flash[:errors]=['Invalid username and password combination']
      redirect_to new_session_url
    end
  end
  
  def destroy
    current_user.reset_session_token! if current_user
    session[:session_token] = nil
    redirect_to new_session_url
  end
  
  
end