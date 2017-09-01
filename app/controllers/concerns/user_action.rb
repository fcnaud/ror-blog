module Concerns
  module UserAction

    extend ActiveSupport::Concern

    def self.included base 
      base.class_eval do
        helper_method :following?
      end
      base.before_action :auth_user, only: [:follow, :unfollow, :uploader_avatar, :update_avatar]
    end

    def following? user
      current_user && current_user.followings.include?(user)
    end

    def comments
      @comments = @user.comments.page(params[:page] || 1).per_page(params[:per_page] || 10)
    end

    def posts
      @posts = Post.page(params[:page] || 1).per_page(params[:per_page] || 25).where("author = '#{@user.username}'")
    end

    def follower
      @users = @user.followers
    end

    def following
      @users = @user.followings
    end

    def follow
      unless following? current_user 
        @user.followers << current_user
      end
      render json: {
          state: 0,
          follower_count: @user.followers.count
      }
    end
    def unfollow
      @user.followers.delete(current_user)
      render json: {
          state: 0,
          follower_count: @user.followers.count
      }
    end


  end
end