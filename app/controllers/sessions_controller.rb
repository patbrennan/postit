class SessionsController < ApplicationController
  def new; end

  def create
    # user.authenticate("password")
    # - get user object
    # - see if password matches
    # - if so, login
    # - if not, error message, render
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      # Never save objects into cookies. Remember they have a very small size limit
      session[:user_id] = user.id
      flash[:notice] = "You are logged in."
      redirect_to root_path
    else
      flash[:error] = "Authentication failed."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are logged out."
    redirect_to root_path
  end
end