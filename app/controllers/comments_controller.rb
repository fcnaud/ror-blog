class CommentsController < ApplicationController
  http_basic_authenticate_with name: 'dcf', password: 'fcnaud',
                               only: :destroy

  def create
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.create(new_comment_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.find_by(id: params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
    def new_comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
