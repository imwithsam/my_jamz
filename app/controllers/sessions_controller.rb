class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by(username: params[:session][:username])

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in, #{user.username}."
      redirect_to songs_path
    else
      flash[:error] = "We were unable to log you in."
      render :new # Render is fater than redirect_to
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out."
    render :new
  end
end
