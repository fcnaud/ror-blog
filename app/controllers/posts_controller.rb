class PostsController < ApplicationController

  before_action :auth_user, except: [:index, :show]

  def index
    @posts = Post.page(params[:page] || 1)
                 .per_page(params[:per_page] || 10)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(new_post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy

    redirect_to posts_path
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.update(edit_post_params)
      redirect_to @post
    else
      render "edit"
    end
  end

private
  def post_params
    params.require(:post).permit(:title, :content)
  end
  def new_post_params
    post_params.merge(author: current_user.username)
  end
  def edit_post_params
    post_params
  end
end
