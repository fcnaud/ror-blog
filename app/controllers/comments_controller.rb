class CommentsController < ApplicationController

  before_action :auth_user, only: [:destroy]

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.create(new_comment_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.find_by(id: params[:id])
    user = User.find(session[:user_id])
    if user.username == @comment.commenter
      @comment.destroy
      redirect_to post_path(@post)
    else

    end
  end

private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
  def new_comment_params
    if session[:user_id]
      user = User.find(session[:user_id])
      comment_params.merge(commenter: user.username)
    else
      comment_params
    end
  end


end
