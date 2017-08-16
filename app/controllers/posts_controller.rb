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
    current_user.posts << @post
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    Post.update_counters @post.id, view_count: 1
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.author == current_user.username
      @post.destroy
      redirect_to posts_path
    else
      render file: 'public/403.html'
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    unless @post.author == current_user.username
      render file: 'public/403.html'
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post.update(edit_post_params)
      redirect_to @post
    else
      render "edit"
    end
  end

  def delete_tag
    @post = Post.find(params[:id])
    @tag = Tag.find(params[:tag_id])
    if !@tag
      render json: {
          state: 0
      }
    else
      @post.tags.delete(@tag) if @post.tags.include?(@tag)
      render json: {
          state: 1
      }
    end
  end
  def add_tag
    @post = Post.find(params[:id])
    @tag = Tag.find(params[:tag_id])
    if !@tag
      render json: {
          state: 0
      }
    else
      @post.tags << @tag unless @post.tags.include?(@tag)
      render json: {
          state: 1
      }
    end
  end
  def edit_tag
    @post = Post.find(params[:id])
    @tag = Tag.find_by(name: params[:tag])
    @tags = Tag.all
  end

private
  def post_params
    params.require(:post).permit(:title, :content)
  end
  def new_post_params
    post_params.merge(author: current_user.username)
  end
  def edit_post_params
    post_params.delete(:title)
  end
end
