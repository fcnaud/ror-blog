class UsersController < ApplicationController
  before_action :set_user, except: [:index, :new, :create]

  include Concerns::UserAction

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      flash[:notice] = '注册成功请登录'
      session[:tmp_username] = @user.username
      redirect_to new_session_path
    else
      render 'new'
    end
  end

  def show
    @posts = Post.page(params[:page] || 1).per_page(params[:per_page] || 10).where("author = '#{@user.username}'")
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def new_user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
  def update_avatar_params
    params.require(:user).permit(:avatar_url)
  end
end
