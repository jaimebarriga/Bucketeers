class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to dashboard_user_path(id: user.id)
  end

  def destroy
    session[:user_id] = nil
    redirect_to welcome_users_path
  end
end