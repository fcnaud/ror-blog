class UsersController < ApplicationController
  before_action :auth_user, only: [:unfollow, :follow]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      redirect_to new_session_path
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
    @posts = Post.page(params[:page] || 1).per_page(params[:per_page] || 25).where("author = '#{@user.username}'")
  end
  def follower
    @user = User.find(params[:id])
    @users = @user.followers
  end
  def following
    @user = User.find(params[:id])
    @users = @user.followings
  end



  def follow
    @user = User.find(params[:id])
    @user.followers << current_user
    render json: {
        state: 0,
        follower_count: @user.followers.count
    }
  end
  def unfollow
    @user = User.find(params[:id])
    @user.followers.delete(current_user)
    render json: {
        state: 0,
        follower_count: @user.followers.count
    }
  end

  def uploader_avatar
    @user = User.find(params[:id])
  end
  def update_avatar
    @user = User.find(params[:id])
    @user.avatar_url = params[:user][:avatar_url]
    if @user.save
      flash[:notice] = "上传头像成功"
      redirect_to user_path(@user)
    else
      flash[:notice] = "上传头像失败"
      render :uploader_avatar
    end
  end



  private
    def new_user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
    def update_avatar_params
      params.require(:user).permit(:avatar_url)
    end
end
