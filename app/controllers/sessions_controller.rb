class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.authenticate(session_params[:username], session_params[:password])
    if @user
      signin_user @user
      flash[:notice] = "login success"
      redirect_to session[:return_to]
    else
      flash[:notice] = "login failed"
      render 'new'
    end
  end

  def destroy
    logout_user
    redirect_to root_path
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end
end
