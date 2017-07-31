class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where("author = '#{@user.username}'")
  end

  private
    def new_user_params
      params.require(:user).permit(:username, :password)
    end
end
