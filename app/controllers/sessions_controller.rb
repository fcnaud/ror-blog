class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(session_params)
    if @user
      signin_user @user
      flash[:notice] = "login success"
      redirect_to root_path
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
