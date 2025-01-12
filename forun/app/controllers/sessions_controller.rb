class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Hi, #{user.username}! You have logged in successfully."
    else
      flash.now[:alert] = "Invalid username."
      render :new
    end
  end

  def destroy
    # user = User.find_by(username: params[:username])
    session[:user_id] = nil
    redirect_to root_path, notice: "Bye! You have logged out successfully."
  end
end
