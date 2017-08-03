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
    @posts = Post.page(params[:page] || 1).per_page(params[:per_page] || 10).where("author = '#{@user.username}'")
    @comments = @user.comments.page(params[:page] || 1).per_page(params[:per_page] || 10)
  end

  def comments
    @user = User.find(params[:id])
    @comments = @user.comments.page(params[:page] || 1).per_page(params[:per_page] || 10)
  end
  def posts
    @user = User.find(params[:id])
    @posts = Post.page(params[:page] || 1).per_page(params[:per_page] || 10).where("author = '#{@user.username}'")
  end

  private
    def new_user_params
      params.require(:user).permit(:username, :password)
    end
end
