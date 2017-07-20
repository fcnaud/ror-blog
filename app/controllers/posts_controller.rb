class PostsController < ApplicationController

  http_basic_authenticate_with name: 'dcf', password: 'fcnaud',
                               except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(edit_post_params)
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
      params.require(:post).permit(:author, :title, :content)
    end
    def new_post_params
      post_params
    end
    def edit_post_params
      post_params
    end
end
