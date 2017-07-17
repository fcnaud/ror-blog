class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    post = Post.new(new_post_params)
    post.save

    redirect_to posts_path
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

private
  def new_post_params
    params.require(:post).permit(:author, :title, :content)
  end
end
