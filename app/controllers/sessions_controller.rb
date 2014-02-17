class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      flash.now.alert = "Invalid Email or Password"
      render "new"
    end
  end

  def delete
    reset_session
  end
end
