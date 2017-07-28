class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(session_params)
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "login success"
      redirect_to root_path
    else
      flash[:notice] = "login failed"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def session_params
    params.require(:session).permit(:username, :password)
  end
end
