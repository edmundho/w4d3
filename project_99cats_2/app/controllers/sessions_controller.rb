class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      redirect_to cats_url
    else
      flash[:errors]=['Invalid username and password combination']
      redirect_to new_session_url
    end
  end
  
end