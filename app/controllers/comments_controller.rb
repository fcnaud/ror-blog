class CommentsController < ApplicationController

  before_action :auth_user, only: [:destroy]

  def create
    if !logged_in?
      redirect_to new_session_path
      return
    end

    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.build(new_comment_params)
    current_user.comments << @comment
    if !@comment.save
      flash[:notice] = "comment failed"
    end
    redirect_to post_path(@post)+'#comment-'+@post.comments.last.id.to_s
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.find_by(id: params[:id])
    if current_user? @comment.user
      if @comment.destroy
        render json: {
            state: 1
        }
      else
        render json: {
            state: 0
        }
        flash[:notice] = "delete faild"
      end
    else
      render json: {
          state: 0,
          data: {
              to_url: 'public/403.html'
          }
      }
    end
  end

private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
  def new_comment_params
    comment_params.merge(commenter: current_user.username)
  end
end
