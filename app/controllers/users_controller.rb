class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      flash[:notice] = "Welcome to MyJamz, #{user.username}!"
      redirect_to new_song_path
    else
      flash[:error] = "Unable to create this account."
      render :new # Render is fater than redirect_to
    end
  end

  # Necessary to prevent XSS
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
